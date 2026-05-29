#!/usr/bin/python3
import os
from logging.config import dictConfig

from flask import Flask, jsonify, request
import psycopg
from psycopg.rows import namedtuple_row
from psycopg_pool import ConnectionPool

dictConfig(
    {
        "version": 1,
        "formatters": {
            "default": {
                "format": "[%(asctime)s] %(levelname)s in %(module)s:%(lineno)s - %(funcName)20s(): %(message)s",
            }
        },
        "handlers": {
            "wsgi": {
                "class": "logging.StreamHandler",
                "stream": "ext://flask.logging.wsgi_errors_stream",
                "formatter": "default",
            }
        },
        "root": {"level": "INFO", "handlers": ["wsgi"]},
    }
)

app = Flask(__name__)
app.config.from_prefixed_env()
log = app.logger

DATABASE_URL = os.environ.get("DATABASE_URL", "postgres://app:app@postgres/app")

pool = ConnectionPool(
    conninfo=DATABASE_URL,
    kwargs={
        "autocommit": True,
        "row_factory": namedtuple_row},
    min_size = 4,
    max_size = 10,
    open = True,
    name = "postgres_pool",
    timeout = 5,
)

@app.route("/zona/<int:zona_id>/", methods=("GET",))
def zona_index(zona_id):
    with pool.connection() as conn:
        with conn.cursor() as cur:
            rows = cur.execute(
                """
                SELECT r.id_recinto, e.nome_cientifico, e.nome_comum, COUNT(a.id_animal) as num_animais
                FROM recinto r
                LEFT JOIN animal a ON r.id_Recinto = a.id_recinto
                LEFT JOIN especie e ON a.nome_cientifico = e.nome_cientifico
                WHERE r.id_zona = %(zona_id)s
                GROUP BY r.id_recinto, e.nome_cientifico, e.nome_comum
                ORDER BY r.id_recinto;
                """,
                {"zona_id": zona_id}
            ).fetchall()

            recintos_dict = {}
            for row in rows:
                id_rec = row.id_recinto
                if id_rec not in recintos_dict:
                    recintos_dict[id_rec] = {"id_recinto": id_rec, "especies": []}
                if row.nome_cientifico:
                    recintos_dict[id_rec]["especies"].append({
                        "nome_cientifico": row.nome_cientifico,
                        "nome_comum": row.nome_comum,
                        "num_animais": row.num_animais
                    })
            resultado = list(recintos_dict.values())
            if not resultado:
                return jsonify({"message": "Zona não encontrada ou sem recintos", "status": "error"}), 404

    return jsonify(resultado), 200

@app.route("/recinto/<int:id_recinto>/voto/<int:bid>/", methods=("POST",))
def recinto_voto_save(id_recinto, bid):
    with pool.connection() as conn:
        with conn.cursor() as cur:
            bilhete = cur.execute("""SELECT votou FROM bilhete WHERE bid = %(bid)s""", {"bid": bid}).fetchone()
            if not bilhete:
                return jsonify({"message": "Bilhete não encontrado", "status": "error"}), 404

            if bilhete.votou is True:
                return jsonify({"message": "Erro: este bilhete já foi usado para votar", "status": "error"}), 400

            recinto = cur.execute("""SELECT id_zona FROM recinto WHERE id_recinto = %(id_recinto)s""", {"id_recinto": id_recinto}).fetchone()
            if not recinto:
                return jsonify({"message": "Zona não encontrada ou sem recintos", "status": "error"}), 404

            tem_acesso = cur.execute("""SELECT 1 FROM acesso WHERE bid = %(bid)s AND id_zona = %(id_zona)s""", {"bid": bid, "id_zona": recinto.id_zona}).fetchone()
            if not tem_acesso:
                return jsonify({"message": "Erro: o bilhete não tem acesso à zona onde este recinto está alocado", "status": "error"}), 403

            try:
                with conn.transaction():
                    cur.execute("""UPDATE bilhete SET votou = TRUE WHERE bid = %(bid)s;""", {"bid": bid})

                    cur.execute("""UPDATE recinto SET votos = votos + 1 WHERE id_recinto = %(id_recinto)s;""", {"id_recinto": id_recinto})
                    
            except Exception as e:
                return jsonify({"message": "Erro interno ao processar o voto.", "status": "error"}), 500

    return jsonify({"message": f"Voto do bilhete {bid} registado com sucesso no recinto {id_recinto}!", "status": "success"}), 200
            

@app.route("/venda/", methods=("POST",))
def venda_save():
    dados = request.get_json()
    if not dados or "bilhetes" not in dados:
        return jsonify({"message": "Erro: Faltam dados de venda", "status": "error"}), 400
    
    nif_cliente = dados.get("nif")
    bilhetes_req = dados.get("bilhetes")

    try:
        with pool.connection() as conn:
            with conn.cursor() as cur:
                with conn.transaction():
                    
                    if nif_cliente:
                        cur.execute("""INSERT INTO venda (data_hora, nif_cliente) VALUES (CURRENT_TIMESTAMP, %(nif)s) RETURNING no_venda;""", {"nif": nif_cliente})
                    else:
                        cur.execute("""INSERT INTO venda (data_hora) VALUES (CURRENT_TIMESTAMP) RETURNING no_venda;""")
                    
                    no_venda = cur.fetchone().no_venda
                    
                    preco_total_venda = 0
                    bilhetes_resposta = []

                    for t in bilhetes_req:
                        zonas_ids = t.get("zonas", [])
                        desconto = t.get("desconto", 0.0)

                        if not zonas_ids:
                            raise ValueError("Um bilhete tem de ter pelo menos um acesso a uma zona")
                        
                        cur.execute("SELECT COALESCE(SUM(preco), 0) AS preco_base FROM zona WHERE id_zona = ANY(%(zonas)s);", {"zonas": zonas_ids})
                        preco_base = cur.fetchone().preco_base

                        preco_bilhete = float(preco_base) * (1 - (float(desconto) / 100))
                        preco_total_venda += preco_bilhete

                        cur.execute("INSERT INTO bilhete (desconto, votou, no_venda) VALUES (%(desconto)s, FALSE, %(no_venda)s) RETURNING bid", {"desconto": desconto, "no_venda": no_venda})
                        bid = cur.fetchone().bid

                        for id_z in zonas_ids:
                            cur.execute("INSERT INTO acesso (bid, id_zona) VALUES (%(bid)s, %(id_zona)s);", {"bid": bid, "id_zona": id_z})

                        bilhetes_resposta.append({
                            "bid": bid,
                            "preco_final": round(preco_bilhete, 2)
                        })

    except ValueError as ve:
        return jsonify({"message": str(ve), "status": "error"}), 400
    except Exception as e:
        return jsonify({"message": "Erro interno ao processar a venda.", "status": "error"}), 500

    return jsonify({
        "no_venda": no_venda,
        "total_venda": round(preco_total_venda, 2),
        "bilhetes": bilhetes_resposta
    }), 201

    


@app.route("/ping", methods=("GET",))
def ping():
    log.debug("ping!")
    return jsonify({"message": "Hi from my NixOS Operating System"}), 200


if __name__ == "__main__":
    app.run()
