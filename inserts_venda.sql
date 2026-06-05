BEGIN;

CREATE INDEX IF NOT EXISTS idx_bilhete_no_venda ON bilhete(no_venda);

TRUNCATE TABLE acesso CASCADE;
TRUNCATE TABLE bilhete CASCADE;
TRUNCATE TABLE venda CASCADE;

-- Esta linha serve para fazer 'babtota' ao RI-4 TEMOS QUE TIRAR ANTES DA ENTREGA -- 
ALTER TABLE venda DISABLE TRIGGER tg_ri4_venda;

DO $$
DECLARE
    data_atual DATE := CAST('2026-01-01' AS DATE);
    data_fim DATE := CAST('2026-06-11' AS DATE);
    is_fds BOOLEAN; qtd_bilhetes INTEGER; v_id INTEGER; b_id INTEGER; i INTEGER;
    combo_idx INTEGER := 0; num_combos INTEGER;
BEGIN
    CREATE TEMPORARY TABLE combos_zona (id SERIAL PRIMARY KEY, zonas_arr INTEGER[]) ON COMMIT DROP;

    WITH RECURSIVE gerar_combos(combo, last_id, cnt) AS (
        SELECT ARRAY[id_zona], id_zona, 1 FROM zona
        UNION ALL
        SELECT c.combo || z.id_zona, z.id_zona, c.cnt + 1 FROM gerar_combos c JOIN zona z ON z.id_zona > c.last_id WHERE c.cnt < 7
    )
    INSERT INTO combos_zona (zonas_arr) SELECT combo FROM gerar_combos WHERE cnt >= 3;
    SELECT count(*) INTO num_combos FROM combos_zona;

    WHILE data_atual <= data_fim LOOP
        is_fds := EXTRACT(DOW FROM data_atual) IN (0, 6);
        IF is_fds THEN qtd_bilhetes := 4000; ELSE qtd_bilhetes := 1000; END IF;

        FOR i IN 1..qtd_bilhetes LOOP
            INSERT INTO venda (data_hora, nif_cliente) VALUES (CAST(CAST(data_atual AS TEXT) || ' 14:00:00' AS TIMESTAMP), '999999999') RETURNING no_venda INTO v_id;
            INSERT INTO bilhete (desconto, votou, no_venda) VALUES (CASE WHEN i % 2 = 0 THEN 50.00 ELSE 0.00 END, CASE WHEN i <= (qtd_bilhetes * 0.8) THEN TRUE ELSE FALSE END, v_id) RETURNING bid INTO b_id;

            IF i <= 10 THEN
                INSERT INTO acesso (bid, id_zona) SELECT b_id, id_zona FROM zona;
            ELSE
                INSERT INTO acesso (bid, id_zona) SELECT b_id, unnest(zonas_arr) FROM combos_zona WHERE id = (combo_idx % num_combos) + 1;
                combo_idx := combo_idx + 1;
            END IF;
        END LOOP;
        data_atual := data_atual + CAST('1 day' AS INTERVAL);
    END LOOP;
END $$;

-- Esta linha serve para desativar a 'babtota' ao RI-4 TEMOS QUE TIRAR ANTES DA ENTREGA -- 
ALTER TABLE venda ENABLE TRIGGER tg_ri4_venda;

UPDATE recinto SET votos = 10;
WITH totais AS (SELECT (SELECT count(*) FROM bilhete WHERE votou = TRUE) as total_votos, (SELECT count(*) FROM recinto) as total_recintos),
distribuicao AS (SELECT (total_votos - (total_recintos * 10)) / total_recintos as extra_por_recinto FROM totais)
UPDATE recinto r SET votos = votos + (SELECT extra_por_recinto FROM distribuicao);

WITH totais AS (SELECT (SELECT count(*) FROM bilhete WHERE votou = TRUE) as total_votos, (SELECT count(*) FROM recinto) as total_recintos),
distribuicao AS (SELECT (total_votos - (total_recintos * 10)) % total_recintos as sobra FROM totais),
recintos_ordenados AS (SELECT id_recinto, ROW_NUMBER() OVER (ORDER BY id_recinto) as rn FROM recinto)
UPDATE recinto r SET votos = r.votos + 1 FROM recintos_ordenados ro, distribuicao d WHERE r.id_recinto = ro.id_recinto AND ro.rn <= d.sobra;

COMMIT;