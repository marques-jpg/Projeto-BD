%%sql
TRUNCATE TABLE zona CASCADE;
TRUNCATE TABLE especie CASCADE;
TRUNCATE TABLE animal CASCADE;



INSERT INTO zona (categoria, continente, preco) VALUES
('Carnívoros', 'África', 15.00), ('Herbívoros', 'África', 12.00),
('Aves', NULL, 8.00), ('Repteis', NULL, 10.00), ('Primatas', NULL, 14.00),
('Mamíferos Marinhos', NULL, 12.00), ('Carnívoros', NULL, 15.00), ('Herbívoros', NULL, 12.00),
(NULL, 'América', 20.00), (NULL, 'Asia', 18.00), (NULL, 'Austrália', 16.00), (NULL, 'Europa', 15.00);



INSERT INTO recinto (id_zona, votos)
SELECT id_zona, 0 FROM zona, generate_series(1, 15);

INSERT INTO recinto (id_zona, votos)
SELECT id_zona, 0
FROM zona, generate_series(1, 15);



INSERT INTO especie (nome_cientifico, nome_comum, categoria, continente) VALUES
-- Carnívoros - África
('Panthera leo', 'Leão', 'Carnívoros', 'África'),
('Acinonyx jubatus', 'Guepardo', 'Carnívoros', 'África'),
('Crocuta crocuta', 'Hiena malhada', 'Carnívoros', 'África'),
('Lycaon pictus', 'Cão selvagem africano', 'Carnívoros', 'África'),
('Caracal caracal', 'Caracal', 'Carnívoros', 'África'),
('Leptailurus serval', 'Serval', 'Carnívoros', 'África'),
('Panthera pardus', 'Leopardo', 'Carnívoros', 'África'),
-- Carnívoros - América
('Panthera onca', 'Onça pintada', 'Carnívoros', 'América'),
('Puma concolor', 'Puma', 'Carnívoros', 'América'),
('Leopardus pardalis', 'Jaguatirica', 'Carnívoros', 'América'),
('Chrysocyon brachyurus', 'Lobo guará', 'Carnívoros', 'América'),
('Tremarctos ornatus', 'Urso de óculos', 'Carnívoros', 'América'),
('Leopardus wiedii', 'Gato maracajá', 'Carnívoros', 'América'),
('Conepatus chinga', 'Cangambá', 'Carnívoros', 'América'),
-- Carnívoros - Asia
('Panthera tigris', 'Tigre', 'Carnívoros', 'Asia'),
('Panthera uncia', 'Leopardo das neves', 'Carnívoros', 'Asia'),
('Ursus thibetanus', 'Urso negro asiático', 'Carnívoros', 'Asia'),
('Cuon alpinus', 'Cão selvagem asiático', 'Carnívoros', 'Asia'),
('Melursus ursinus', 'Urso beiçudo', 'Carnívoros', 'Asia'),
('Neofelis nebulosa', 'Pantera nebulosa', 'Carnívoros', 'Asia'),
('Prionailurus viverrinus', 'Gato pescador', 'Carnívoros', 'Asia'),
-- Carnívoros - Austrália
('Sarcophilus harrisii', 'Diabo da tasmânia', 'Carnívoros', 'Austrália'),
('Dasyurus maculatus', 'Quoll de cauda malhada', 'Carnívoros', 'Austrália'),
('Dasyurus viverrinus', 'Quoll oriental', 'Carnívoros', 'Austrália'),
('Dasyurus geoffroii', 'Quoll ocidental', 'Carnívoros', 'Austrália'),
('Phascogale tapoatafa', 'Fascogale', 'Carnívoros', 'Austrália'),
('Antechinus stuartii', 'Antechinus', 'Carnívoros', 'Austrália'),
('Planigale maculata', 'Planigale', 'Carnívoros', 'Austrália'),
-- Carnívoros - Europa
('Ursus arctos', 'Urso pardo', 'Carnívoros', 'Europa'),
('Canis lupus', 'Lobo', 'Carnívoros', 'Europa'),
('Lynx lynx', 'Lince euroasiático', 'Carnívoros', 'Europa'),
('Lynx pardinus', 'Lince ibérico', 'Carnívoros', 'Europa'),
('Gulo gulo', 'Carcaju', 'Carnívoros', 'Europa'),
('Mustela lutreola', 'Vison europeu', 'Carnívoros', 'Europa'),
('Meles meles', 'Texugo europeu', 'Carnívoros', 'Europa'),

-- Herbívoros - África
('Loxodonta africana', 'Elefante africano', 'Herbívoros', 'África'),
('Giraffa camelopardalis', 'Girafa', 'Herbívoros', 'África'),
('Syncerus caffer', 'Búfalo africano', 'Herbívoros', 'África'),
('Hippopotamus amphibius', 'Hipopótamo', 'Herbívoros', 'África'),
('Diceros bicornis', 'Rinoceronte negro', 'Herbívoros', 'África'),
('Equus quagga', 'Zebra planície', 'Herbívoros', 'África'),
('Connochaetes taurinus', 'Gnu azul', 'Herbívoros', 'África'),
-- Herbívoros - América
('Alces alces', 'Alce', 'Herbívoros', 'América'),
('Rangifer tarandus', 'Rena', 'Herbívoros', 'América'),
('Odocoileus virginianus', 'Veado de cauda branca', 'Herbívoros', 'América'),
('Tapirus terrestris', 'Anta brasileira', 'Herbívoros', 'América'),
('Blastocerus dichotomus', 'Veado do pântano', 'Herbívoros', 'América'),
('Pudu puda', 'Pudu', 'Herbívoros', 'América'),
('Hippocamelus antisensis', 'Taruca', 'Herbívoros', 'América'),
-- Herbívoros - Asia
('Elephas maximus', 'Elefante asiático', 'Herbívoros', 'Asia'),
('Rhinoceros unicornis', 'Rinoceronte indiano', 'Herbívoros', 'Asia'),
('Tapirus indicus', 'Anta malaia', 'Herbívoros', 'Asia'),
('Bos gaurus', 'Gauro', 'Herbívoros', 'Asia'),
('Rusa unicolor', 'Sambar', 'Herbívoros', 'Asia'),
('Axis axis', 'Chital', 'Herbívoros', 'Asia'),
('Camelus bactrianus', 'Camelo bactriano', 'Herbívoros', 'Asia'),
-- Herbívoros - Austrália
('Macropus giganteus', 'Canguru cinzento oriental', 'Herbívoros', 'Austrália'),
('Osphranter rufus', 'Canguru vermelho', 'Herbívoros', 'Austrália'),
('Vombatus ursinus', 'Vombate', 'Herbívoros', 'Austrália'),
('Phascolarctos cinereus', 'Coala', 'Herbívoros', 'Austrália'),
('Wallabia bicolor', 'Wallaby bicolor', 'Herbívoros', 'Austrália'),
('Notamacropus rufogriseus', 'Wallaby de pescoço vermelho', 'Herbívoros', 'Austrália'),
('Lasiorhinus latifrons', 'Vombate de nariz peludo', 'Herbívoros', 'Austrália'),
-- Herbívoros - Europa
('Bison bonasus', 'Bisão europeu', 'Herbívoros', 'Europa'),
('Cervus elaphus', 'Veado vermelho', 'Herbívoros', 'Europa'),
('Capreolus capreolus', 'Corço', 'Herbívoros', 'Europa'),
('Rupicapra rupicapra', 'Camurça', 'Herbívoros', 'Europa'),
('Capra ibex', 'Íbex dos alpes', 'Herbívoros', 'Europa'),
('Sus scrofa', 'Javali', 'Herbívoros', 'Europa'),
('Dama dama', 'Gamo', 'Herbívoros', 'Europa'),

-- Aves - África
('Struthio camelus', 'Avestruz', 'Aves', 'África'),
('Balearica regulorum', 'Grou coroado', 'Aves', 'África'),
('Sagittarius serpentarius', 'Secretário', 'Aves', 'África'),
('Bucorvus leadbeateri', 'Calau terrestre', 'Aves', 'África'),
('Agapornis roseicollis', 'Inseparável', 'Aves', 'África'),
('Neophron percnopterus', 'Abutre egípcio', 'Aves', 'África'),
('Scopus umbretta', 'Pássaro martelo', 'Aves', 'África'),
-- Aves - América
('Ara macao', 'Arara vermelha', 'Aves', 'América'),
('Ramphastos toco', 'Tucano toco', 'Aves', 'América'),
('Harpia harpyja', 'Harpia', 'Aves', 'América'),
('Phoenicopterus chilensis', 'Flamingo chileno', 'Aves', 'América'),
('Vultur gryphus', 'Condor dos andes', 'Aves', 'América'),
('Rhea americana', 'Ema', 'Aves', 'América'),
('Calypte anna', 'Beija flor de anna', 'Aves', 'América'),
-- Aves - Asia
('Pavo cristatus', 'Pavão indiano', 'Aves', 'Asia'),
('Buceros bicornis', 'Calau bicorne', 'Aves', 'Asia'),
('Lophura ignita', 'Faisão nobre', 'Aves', 'Asia'),
('Haliaeetus pelagicus', 'Águia de steller', 'Aves', 'Asia'),
('Grus japonensis', 'Grou da manchúria', 'Aves', 'Asia'),
('Ciconia boyciana', 'Cegonha oriental', 'Aves', 'Asia'),
('Argusianus argus', 'Argus gigante', 'Aves', 'Asia'),
-- Aves - Austrália
('Dromaius novaehollandiae', 'Emu', 'Aves', 'Austrália'),
('Dacelo novaeguineae', 'Cucaburra', 'Aves', 'Austrália'),
('Cacatua galerita', 'Cacatua de crista amarela', 'Aves', 'Austrália'),
('Eolophus roseicapilla', 'Galah', 'Aves', 'Austrália'),
('Casuarius casuarius', 'Casuar', 'Aves', 'Austrália'),
('Podargus strigoides', 'Podargo', 'Aves', 'Austrália'),
('Menura novaehollandiae', 'Ave lira', 'Aves', 'Austrália'),
-- Aves - Europa
('Ciconia ciconia', 'Cegonha branca', 'Aves', 'Europa'),
('Aquila chrysaetos', 'Águia real', 'Aves', 'Europa'),
('Erithacus rubecula', 'Pisco de peito ruivo', 'Aves', 'Europa'),
('Bubo bubo', 'Bufo real', 'Aves', 'Europa'),
('Alcedo atthis', 'Guarda rios', 'Aves', 'Europa'),
('Cygnus olor', 'Cisne branco', 'Aves', 'Europa'),
('Perdix perdix', 'Perdiz cinzenta', 'Aves', 'Europa'),

-- Primatas - África
('Pan troglodytes', 'Chimpanzé', 'Primatas', 'África'),
('Gorilla beringei', 'Gorila das montanhas', 'Primatas', 'África'),
('Mandrillus sphinx', 'Mandril', 'Primatas', 'África'),
('Papio anubis', 'Babíno anúbis', 'Primatas', 'África'),
('Colobus guereza', 'Colobo guereza', 'Primatas', 'África'),
('Lemur catta', 'Lémur de cauda anelada', 'Primatas', 'África'),
('Daubentonia madagascariensis', 'Aye aye', 'Primatas', 'África'),
-- Primatas - América
('Alouatta caraya', 'Bugio preto', 'Primatas', 'América'),
('Cebus capucinus', 'Macaco prego', 'Primatas', 'América'),
('Leontopithecus rosalia', 'Mico leão dourado', 'Primatas', 'América'),
('Ateles paniscus', 'Macaco aranha', 'Primatas', 'América'),
('Saimiri sciureus', 'Macaco de cheiro', 'Primatas', 'América'),
('Saguinus imperator', 'Tamarin imperador', 'Primatas', 'América'),
('Cacajao calvus', 'Uacari branco', 'Primatas', 'América'),
-- Primatas - Asia
('Pongo pygmaeus', 'Orangotango de borneu', 'Primatas', 'Asia'),
('Hylobates lar', 'Gibão de mãos brancas', 'Primatas', 'Asia'),
('Macaca mulatta', 'Macaco rhesus', 'Primatas', 'Asia'),
('Nasalis larvatus', 'Macaco narigudo', 'Primatas', 'Asia'),
('Trachypithecus johnii', 'Langur de nilgiri', 'Primatas', 'Asia'),
('Nycticebus coucang', 'Loris lento', 'Primatas', 'Asia'),
('Rhinopithecus roxellana', 'Macaco dourado', 'Primatas', 'Asia'),
-- Primatas - Europa e América adicionais
('Macaca sylvanus', 'Macaco de gibraltar', 'Primatas', 'Europa'),
('Saimiri oerstedii', 'Macaco de cheiro centro americano', 'Primatas', 'América'),
('Cebus albifrons', 'Macaco prego de frente branca', 'Primatas', 'América'),
('Ateles geoffroyi', 'Macaco aranha de geoffroy', 'Primatas', 'América'),
('Alouatta palliata', 'Bugio de manto', 'Primatas', 'América'),
('Saguinus geoffroyi', 'Tamarin de geoffroy', 'Primatas', 'América'),
('Callithrix jacchus', 'Sagui comum', 'Primatas', 'América'),

-- Mamíferos Marinhos - África
('Arctocephalus pusillus', 'Lobo marinho africano', 'Mamíferos Marinhos', 'África'),
('Tursiops aduncus', 'Golfinho do indopacífico', 'Mamíferos Marinhos', 'África'),
('Sousa teuszii', 'Golfinho do atlântico', 'Mamíferos Marinhos', 'África'),
('Dugong dugon', 'Dugongo', 'Mamíferos Marinhos', 'África'),
('Arctocephalus tropicalis', 'Lobo marinho subantártico', 'Mamíferos Marinhos', 'África'),
-- Mamíferos Marinhos - América
('Trichechus manatus', 'Peixe boi marinho', 'Mamíferos Marinhos', 'América'),
('Mirounga angustirostris', 'Elefante marinho do norte', 'Mamíferos Marinhos', 'América'),
('Otaria flavescens', 'Leão marinho sul americano', 'Mamíferos Marinhos', 'América'),
('Phoca vitulina', 'Foca comum', 'Mamíferos Marinhos', 'América'),
('Zalophus californianus', 'Leão marinho da califórnia', 'Mamíferos Marinhos', 'América'),
('Inia geoffrensis', 'Boto cor de rosa', 'Mamíferos Marinhos', 'América'),
('Trichechus inunguis', 'Peixe boi da amazónia', 'Mamíferos Marinhos', 'América'),
-- Mamíferos Marinhos - Asia
('Pusa sibirica', 'Foca de baikal', 'Mamíferos Marinhos', 'Asia'),
('Neophocaena phocaenoides', 'Boto do yangtzé', 'Mamíferos Marinhos', 'Asia'),
('Platanista gangetica', 'Golfinho do ganges', 'Mamíferos Marinhos', 'Asia'),
('Sousa chinensis', 'Golfinho branco chinês', 'Mamíferos Marinhos', 'Asia'),
('Pusa caspica', 'Foca do cáspio', 'Mamíferos Marinhos', 'Asia'),
-- Mamíferos Marinhos - Austrália
('Neophoca cinerea', 'Leão marinho australiano', 'Mamíferos Marinhos', 'Austrália'),
('Arctocephalus forsteri', 'Lobo marinho da nova zelândia', 'Mamíferos Marinhos', 'Austrália'),
('Orcaella heinsohni', 'Golfinho de snubfin', 'Mamíferos Marinhos', 'Austrália'),
('Tursiops australis', 'Golfinho de burrunan', 'Mamíferos Marinhos', 'Austrália'),
-- Mamíferos Marinhos - Europa
('Halichoerus grypus', 'Foca cinzenta', 'Mamíferos Marinhos', 'Europa'),
('Monachus monachus', 'Foca monge do mediterrâneo', 'Mamíferos Marinhos', 'Europa'),
('Phocoena phocoena', 'Boto comum', 'Mamíferos Marinhos', 'Europa'),
('Delphinus delphis', 'Golfinho comum', 'Mamíferos Marinhos', 'Europa'),
('Grampus griseus', 'Golfinho de risso', 'Mamíferos Marinhos', 'Europa'),

-- Repteis - África
('Crocodylus niloticus', 'Crocodilo do nilo', 'Repteis', 'África'),
('Python sebae', 'Pitão africana', 'Repteis', 'África'),
('Dendroaspis polylepis', 'Mamba negra', 'Repteis', 'África'),
('Chamaeleo dilepis', 'Camaleão comum', 'Repteis', 'África'),
('Geochelone pardalis', 'Tartaruga leopardo', 'Repteis', 'África'),
('Bitis arietans', 'Víbora sopradora', 'Repteis', 'África'),
('Naja haje', 'Naja egípcia', 'Repteis', 'África'),
-- Repteis - América
('Alligator mississippiensis', 'Jacaré americano', 'Repteis', 'América'),
('Iguana iguana', 'Iguana verde', 'Repteis', 'América'),
('Boa constrictor', 'Jiboia', 'Repteis', 'América'),
('Crotalus durissus', 'Cascavel', 'Repteis', 'América'),
('Podocnemis expansa', 'Tartaruga da amazónia', 'Repteis', 'América'),
('Caiman crocodilus', 'Jacaré tinga', 'Repteis', 'América'),
('Eunectes murinus', 'Sucuri verde', 'Repteis', 'América'),
-- Repteis - Asia
('Varanus komodoensis', 'Dragão de komodo', 'Repteis', 'Asia'),
('Python reticulatus', 'Pitão reticulada', 'Repteis', 'Asia'),
('Ophiophagus hannah', 'Naja rei', 'Repteis', 'Asia'),
('Crocodylus porosus', 'Crocodilo de água salgada', 'Repteis', 'Asia'),
('Gavialis gangeticus', 'Gavial', 'Repteis', 'Asia'),
('Varanus salvator', 'Lagarto monitor de água', 'Repteis', 'Asia'),
('Tomistoma schlegelii', 'Falso gavial', 'Repteis', 'Asia'),
-- Repteis - Austrália
('Crocodylus johnstoni', 'Crocodilo de água doce', 'Repteis', 'Austrália'),
('Tiliqua scincoides', 'Lagarto de língua azul', 'Repteis', 'Austrália'),
('Varanus giganteus', 'Perentie', 'Repteis', 'Austrália'),
('Pseudonaja textilis', 'Cobra castanha comum', 'Repteis', 'Austrália'),
('Oxyuranus scutellatus', 'Taipan da costa', 'Repteis', 'Austrália'),
('Intellagama lesueurii', 'Dragão de água australiano', 'Repteis', 'Austrália'),
('Chlamydosaurus kingii', 'Lagarto de gola', 'Repteis', 'Austrália'),
-- Repteis - Europa
('Vipera berus', 'Víbora cruzada', 'Repteis', 'Europa'),
('Natrix natrix', 'Cobra de água de colar', 'Repteis', 'Europa'),
('Lacerta viridis', 'Lagarto verde europeu', 'Repteis', 'Europa'),
('Testudo hermanni', 'Tartaruga de hermann', 'Repteis', 'Europa'),
('Emys orbicularis', 'Cágado europeu', 'Repteis', 'Europa'),
('Zamenis longissimus', 'Cobra de esculápio', 'Repteis', 'Europa'),
('Anguis fragilis', 'Licranço', 'Repteis', 'Europa'),

-- Aves adicionais na Europa para perfazer o volume total regulamentar
('Accipiter nisus', 'Gavião da europa', 'Aves', 'Europa'),
('Falco tinnunculus', 'Peneireiro comum', 'Aves', 'Europa'),
('Strix aluco', 'Coruja do mato', 'Aves', 'Europa'),
('Passer domesticus', 'Pardal comum', 'Aves', 'Europa'),
('Turdus merula', 'Melro preto', 'Aves', 'Europa'),
('Columba livia', 'Pombo comum', 'Aves', 'Europa'),
('Corvus corone', 'Gralha preta', 'Aves', 'Europa'),
('Pica pica', 'Pega rabuda', 'Aves', 'Europa'),
('Garrulus glandarius', 'Gaio comum', 'Aves', 'Europa'),
('Hirundo rustica', 'Andorinha das chaminés', 'Aves', 'Europa'),
('Motacilla alba', 'Alvéola branca', 'Aves', 'Europa'),
('Carduelis carduelis', 'Pintassilgo', 'Aves', 'Europa'),
('Chloris chloris', 'Verdelhão', 'Aves', 'Europa'),
('Fringilla coelebs', 'Tentilhão comum', 'Aves', 'Europa'),
('Anas platyrhynchos', 'Pato real', 'Aves', 'Europa'),
('Ardea cinerea', 'Garça real', 'Aves', 'Europa'),
('Fulica atra', 'Galeirão comum', 'Aves', 'Europa'),
('Gallinula chloropus', 'Galinha de água', 'Aves', 'Europa'),
('Larus michahellis', 'Gaivota de patas amarelas', 'Aves', 'Europa'),
('Phalacrocorax carbo', 'Corvo marinho', 'Aves', 'Europa'),
('Podiceps cristatus', 'Mergulhão de crista', 'Aves', 'Europa'),
('Tachybaptus ruficollis', 'Mergulhão pequeno', 'Aves', 'Europa'),
('Vanellus vanellus', 'Abibe comum', 'Aves', 'Europa'),
('Scolopax rusticola', 'Galinhola', 'Aves', 'Europa'),
('Numenius arquata', 'Maçarico real', 'Aves', 'Europa'),
('Calidris alpina', 'Pilrito comum', 'Aves', 'Europa'),
('Tringa totanus', 'Perna vermelha comum', 'Aves', 'Europa'),
('Pluvialis apricaria', 'Tarambola dourada', 'Aves', 'Europa'),
('Charadrius hiaticula', 'Borrelho de coleira grande', 'Aves', 'Europa'),
('Haematopus ostralegus', 'Ostraceiro', 'Aves', 'Europa'),
('Recurvirostra avosetta', 'Avoceta', 'Aves', 'Europa'),
('Himantopus himantopus', 'Perna longa', 'Aves', 'Europa'),
('Phoenicopterus roseus', 'Flamingo comum', 'Aves', 'Europa'),
('Platalea leucorodia', 'Colhereiro', 'Aves', 'Europa'),
('Plegadis falcinellus', 'Íbis preta', 'Aves', 'Europa'),
('Bubulcus ibis', 'Garça vaqueira', 'Aves', 'Europa'),
('Egretta garzetta', 'Garça branca pequena', 'Aves', 'Europa'),
('Nycticorax nycticorax', 'Goraz', 'Aves', 'Europa'),
('Ixobrychus minutus', 'Garçote', 'Aves', 'Europa'),
('Botaurus stellaris', 'Abetouro', 'Aves', 'Europa'),
('Ciconia nigra', 'Cegonha preta', 'Aves', 'Europa'),
('Pandion haliaetus', 'Águia pesqueira', 'Aves', 'Europa'),
('Pernis apivorus', 'Bútio vespeiro', 'Aves', 'Europa'),
('Milvus milvus', 'Milhano', 'Aves', 'Europa'),
('Milvus migrans', 'Milhafre preto', 'Aves', 'Europa'),
('Haliaeetus albicilla', 'Águia rabalva', 'Aves', 'Europa'),
('Circus aeruginosus', 'Tartaranhão ruivo dos pauis', 'Aves', 'Europa'),
('Circus cyaneus', 'Tartaranhão azul', 'Aves', 'Europa'),
('Circus pygargus', 'Tartaranhão caçador', 'Aves', 'Europa'),
('Accipiter gentilis', 'Açor', 'Aves', 'Europa'),
('Buteo buteo', 'Bútio comum', 'Aves', 'Europa'),
('Aquila adalberti', 'Águia imperial ibérica', 'Aves', 'Europa'),
('Hieraaetus pennatus', 'Águia calçada', 'Aves', 'Europa'),
('Aquila fasciata', 'Águia de bonelli', 'Aves', 'Europa'),
('Falco naumanni', 'Peneireiro das torres', 'Aves', 'Europa'),
('Falco columbarius', 'Esmerejão', 'Aves', 'Europa'),
('Falco subbuteo', 'Óutão', 'Aves', 'Europa'),
('Falco eleonorae', 'Falcão da rainha', 'Aves', 'Europa'),
('Falco peregrinus', 'Falcão peregrino', 'Aves', 'Europa'),
('Alectoris rufa', 'Perdiz vermelha', 'Aves', 'Europa'),
('Coturnix coturnix', 'Codorniz', 'Aves', 'Europa'),
('Phasianus colchicus', 'Faisão comum', 'Aves', 'Europa'),
('Rallus aquaticus', 'Frango de água', 'Aves', 'Europa'),
('Porzana porzana', 'Franga de água marã', 'Aves', 'Europa'),
('Crex crex', 'Codornizão', 'Aves', 'Europa'),
('Otis tarda', 'Abetarda', 'Aves', 'Europa'),
('Tetrax tetrax', 'Sisão', 'Aves', 'Europa'),
('Turnix sylvaticus', 'Toirão', 'Aves', 'Europa'),
('Burhinus oedicnemus', 'Alcaravão', 'Aves', 'Europa'),
('Cursorius cursor', 'Corredor', 'Aves', 'Europa'),
('Glareola pratincola', 'Perdiz do mar', 'Aves', 'Europa');




WITH especies_ordenadas AS (
    SELECT nome_cientifico, categoria, continente,
           ROW_NUMBER() OVER (ORDER BY nome_cientifico) as rn_esp
    FROM especie
),
distribuicao_animais AS (
    SELECT nome_cientifico, categoria, continente, rn_esp,
           CASE 
               WHEN rn_esp <= 100 THEN 2
               WHEN rn_esp BETWEEN 101 AND 160 THEN 1
               WHEN rn_esp BETWEEN 161 AND 200 THEN 4
               ELSE 3
           END as qtd
    FROM especies_ordenadas
),
animais_expandidos AS (
    SELECT nome_cientifico, categoria, continente, rn_esp, qtd,
           generate_series(1, qtd) as animal_idx
    FROM distribuicao_animais
),
recintos_disponiveis AS (
    SELECT r.id_recinto, z.id_zona, z.categoria as z_cat, z.continente as z_cnt,
           ROW_NUMBER() OVER (PARTITION BY z.categoria, z.continente ORDER BY r.id_recinto) as rn_rec
    FROM recinto r
    JOIN zona z ON r.id_zona = z.id_zona
),
mapeamento_final AS (
    SELECT a.*,
           (
               SELECT id_recinto 
               FROM recintos_disponiveis rd
               WHERE (rd.z_cat IS NULL OR rd.z_cat = a.categoria)
                 AND (rd.z_cnt IS NULL OR rd.z_cnt = a.continente)
               ORDER BY (a.rn_esp % 10)
               LIMIT 1
           ) as recinto_id
    FROM animais_expandidos a
)
INSERT INTO animal (nome, nome_cientifico, id_recinto, data_nasc)
SELECT 
    'Animal_' || ROW_NUMBER() OVER (ORDER BY nome_cientifico, animal_idx),
    nome_cientifico,
    recinto_id,
    CAST('2018-01-01'::DATE + (rn_esp * 7 || ' days')::INTERVAL AS DATE)
FROM mapeamento_final;

COMMIT;