// =====================================================
// Projeto Neo4j – Imobiliária | Dados Fictícios (MVP) - Revisado (Idempotente)
// Arquivo: dados-ficticios.cypher
// Observação: pode ser executado várias vezes sem quebrar constraints.
// =====================================================

// -----------------------------------------------------
// 0) (Opcional) RESET TOTAL DO BANCO
// Use SOMENTE se quiser apagar tudo e recomeçar do zero.
// -----------------------------------------------------
// MATCH (n) DETACH DELETE n;

// -----------------------------------------------------
// 1) Constraints / Indexes (recomendado)
// -----------------------------------------------------
CREATE CONSTRAINT imovel_id_unique IF NOT EXISTS
FOR (i:Imovel) REQUIRE i.id IS UNIQUE;

CREATE CONSTRAINT bairro_nome_unique IF NOT EXISTS
FOR (b:Bairro) REQUIRE (b.nome, b.cidade) IS UNIQUE;

CREATE CONSTRAINT amenidade_tipo_unique IF NOT EXISTS
FOR (a:Amenidade) REQUIRE a.tipo IS UNIQUE;

CREATE CONSTRAINT cliente_nome_unique IF NOT EXISTS
FOR (c:Cliente) REQUIRE c.nome IS UNIQUE;

CREATE CONSTRAINT corretor_creci_unique IF NOT EXISTS
FOR (r:Corretor) REQUIRE r.registro_creci IS UNIQUE;

// -----------------------------------------------------
// 2) Bairros (catálogo)
// -----------------------------------------------------
MERGE (b:Bairro {nome: "Centro", cidade: "Campinas"})
SET b.regiao = "Central";

MERGE (b:Bairro {nome: "Taquaral", cidade: "Campinas"})
SET b.regiao = "Norte";

MERGE (b:Bairro {nome: "Cambuí", cidade: "Campinas"})
SET b.regiao = "Nobre";

MERGE (b:Bairro {nome: "Barão Geraldo", cidade: "Campinas"})
SET b.regiao = "Distrito";

MERGE (b:Bairro {nome: "Jardim Proença", cidade: "Campinas"})
SET b.regiao = "Oeste";

// -----------------------------------------------------
// 3) Amenidades (catálogo) - padrão correto MERGE + SET
// -----------------------------------------------------
MERGE (a:Amenidade {tipo: "Metrô"})
SET a.categoria = "Transporte";

MERGE (a:Amenidade {tipo: "Parque"})
SET a.categoria = "Lazer";

MERGE (a:Amenidade {tipo: "Escola"})
SET a.categoria = "Serviços";

MERGE (a:Amenidade {tipo: "Shopping"})
SET a.categoria = "Comércio";

MERGE (a:Amenidade {tipo: "Hospital"})
SET a.categoria = "Serviços";

MERGE (a:Amenidade {tipo: "Academia"})
SET a.categoria = "Lazer";

MERGE (a:Amenidade {tipo: "Mercado"})
SET a.categoria = "Comércio";

MERGE (a:Amenidade {tipo: "Ciclovia"})
SET a.categoria = "Mobilidade";

// -----------------------------------------------------
// 4) Corretores
// -----------------------------------------------------
MERGE (r:Corretor {registro_creci: "12345-SP"})
SET r.nome = "Carlos Souza";

MERGE (r:Corretor {registro_creci: "67890-SP"})
SET r.nome = "Ana Lima";

// -----------------------------------------------------
// 5) Imóveis
// -----------------------------------------------------
MERGE (i:Imovel {id: 101})
SET i.tipo="Apartamento", i.valor=450000, i.area_m2=65,  i.quartos=2, i.vagas=1;

MERGE (i:Imovel {id: 102})
SET i.tipo="Apartamento", i.valor=620000, i.area_m2=85,  i.quartos=3, i.vagas=2;

MERGE (i:Imovel {id: 103})
SET i.tipo="Casa",        i.valor=780000, i.area_m2=120, i.quartos=3, i.vagas=2;

MERGE (i:Imovel {id: 104})
SET i.tipo="Casa",        i.valor=980000, i.area_m2=160, i.quartos=4, i.vagas=3;

MERGE (i:Imovel {id: 105})
SET i.tipo="Studio",      i.valor=320000, i.area_m2=38,  i.quartos=1, i.vagas=0;

MERGE (i:Imovel {id: 106})
SET i.tipo="Apartamento", i.valor=510000, i.area_m2=72,  i.quartos=2, i.vagas=1;

MERGE (i:Imovel {id: 107})
SET i.tipo="Apartamento", i.valor=690000, i.area_m2=92,  i.quartos=3, i.vagas=2;

MERGE (i:Imovel {id: 108})
SET i.tipo="Casa",        i.valor=850000, i.area_m2=135, i.quartos=3, i.vagas=2;

MERGE (i:Imovel {id: 109})
SET i.tipo="Studio",      i.valor=280000, i.area_m2=32,  i.quartos=1, i.vagas=0;

MERGE (i:Imovel {id: 110})
SET i.tipo="Apartamento", i.valor=740000, i.area_m2=98,  i.quartos=3, i.vagas=2;

// -----------------------------------------------------
// 6) Clientes
// -----------------------------------------------------
MERGE (c:Cliente {nome: "Maria Silva"})
SET c.telefone="19 99999-1111", c.faixa_renda="8k-12k",  c.aceita_financiamento=true;

MERGE (c:Cliente {nome: "João Pereira"})
SET c.telefone="19 98888-2222", c.faixa_renda="5k-8k",   c.aceita_financiamento=true;

MERGE (c:Cliente {nome: "Ana Costa"})
SET c.telefone="19 97777-3333", c.faixa_renda="12k-18k", c.aceita_financiamento=false;

MERGE (c:Cliente {nome: "Bruno Alves"})
SET c.telefone="19 96666-4444", c.faixa_renda="4k-6k",   c.aceita_financiamento=true;

MERGE (c:Cliente {nome: "Carla Mendes"})
SET c.telefone="19 95555-5555", c.faixa_renda="10k-15k", c.aceita_financiamento=true;

MERGE (c:Cliente {nome: "Diego Rocha"})
SET c.telefone="19 94444-6666", c.faixa_renda="6k-10k",  c.aceita_financiamento=true;

// -----------------------------------------------------
// 7) Imóvel -> Bairro (LOCALIZADO_EM)
// -----------------------------------------------------
MATCH (i:Imovel {id: 101}), (b:Bairro {nome: "Centro", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 102}), (b:Bairro {nome: "Cambuí", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 103}), (b:Bairro {nome: "Taquaral", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 104}), (b:Bairro {nome: "Barão Geraldo", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 105}), (b:Bairro {nome: "Centro", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 106}), (b:Bairro {nome: "Jardim Proença", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 107}), (b:Bairro {nome: "Cambuí", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 108}), (b:Bairro {nome: "Taquaral", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 109}), (b:Bairro {nome: "Centro", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

MATCH (i:Imovel {id: 110}), (b:Bairro {nome: "Cambuí", cidade: "Campinas"})
MERGE (i)-[:LOCALIZADO_EM]->(b);

// -----------------------------------------------------
// 8) Imóvel -> Amenidade (TEM_AMENIDADE)
// -----------------------------------------------------
MATCH (i:Imovel {id: 101}), (a:Amenidade {tipo: "Metrô"})     MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 101}), (a:Amenidade {tipo: "Mercado"})   MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 101}), (a:Amenidade {tipo: "Hospital"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 102}), (a:Amenidade {tipo: "Shopping"})  MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 102}), (a:Amenidade {tipo: "Academia"})  MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 102}), (a:Amenidade {tipo: "Mercado"})   MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 103}), (a:Amenidade {tipo: "Parque"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 103}), (a:Amenidade {tipo: "Escola"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 103}), (a:Amenidade {tipo: "Ciclovia"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 104}), (a:Amenidade {tipo: "Parque"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 104}), (a:Amenidade {tipo: "Hospital"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 105}), (a:Amenidade {tipo: "Metrô"})     MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 105}), (a:Amenidade {tipo: "Shopping"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 106}), (a:Amenidade {tipo: "Escola"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 106}), (a:Amenidade {tipo: "Mercado"})   MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 107}), (a:Amenidade {tipo: "Academia"})  MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 107}), (a:Amenidade {tipo: "Shopping"})  MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 107}), (a:Amenidade {tipo: "Hospital"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 108}), (a:Amenidade {tipo: "Parque"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 108}), (a:Amenidade {tipo: "Mercado"})   MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 109}), (a:Amenidade {tipo: "Metrô"})     MERGE (i)-[:TEM_AMENIDADE]->(a);

MATCH (i:Imovel {id: 110}), (a:Amenidade {tipo: "Shopping"})  MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 110}), (a:Amenidade {tipo: "Escola"})    MERGE (i)-[:TEM_AMENIDADE]->(a);
MATCH (i:Imovel {id: 110}), (a:Amenidade {tipo: "Ciclovia"})  MERGE (i)-[:TEM_AMENIDADE]->(a);

// -----------------------------------------------------
// 9) Corretor -> Cliente (ATENDE) | Corretor -> Imóvel (CAPTOU)
// -----------------------------------------------------
MATCH (r:Corretor {registro_creci: "12345-SP"}), (c:Cliente {nome: "Maria Silva"})  MERGE (r)-[:ATENDE]->(c);
MATCH (r:Corretor {registro_creci: "12345-SP"}), (c:Cliente {nome: "João Pereira"}) MERGE (r)-[:ATENDE]->(c);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (c:Cliente {nome: "Ana Costa"})    MERGE (r)-[:ATENDE]->(c);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (c:Cliente {nome: "Carla Mendes"}) MERGE (r)-[:ATENDE]->(c);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (c:Cliente {nome: "Diego Rocha"})  MERGE (r)-[:ATENDE]->(c);

MATCH (r:Corretor {registro_creci: "12345-SP"}), (i:Imovel {id: 101}) MERGE (r)-[:CAPTOU]->(i);
MATCH (r:Corretor {registro_creci: "12345-SP"}), (i:Imovel {id: 103}) MERGE (r)-[:CAPTOU]->(i);
MATCH (r:Corretor {registro_creci: "12345-SP"}), (i:Imovel {id: 105}) MERGE (r)-[:CAPTOU]->(i);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (i:Imovel {id: 102}) MERGE (r)-[:CAPTOU]->(i);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (i:Imovel {id: 104}) MERGE (r)-[:CAPTOU]->(i);
MATCH (r:Corretor {registro_creci: "67890-SP"}), (i:Imovel {id: 110}) MERGE (r)-[:CAPTOU]->(i);

// -----------------------------------------------------
// 10) Cliente -> Amenidade (PREFERE) com peso
// Dica: MERGE garante que o mesmo peso não será duplicado.
// -----------------------------------------------------
MATCH (c:Cliente {nome: "Maria Silva"}), (a:Amenidade {tipo: "Parque"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 5;

MATCH (c:Cliente {nome: "Maria Silva"}), (a:Amenidade {tipo: "Escola"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 4;

MATCH (c:Cliente {nome: "Maria Silva"}), (a:Amenidade {tipo: "Mercado"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 3;

MATCH (c:Cliente {nome: "João Pereira"}), (a:Amenidade {tipo: "Metrô"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 5;

MATCH (c:Cliente {nome: "João Pereira"}), (a:Amenidade {tipo: "Shopping"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 3;

MATCH (c:Cliente {nome: "Ana Costa"}), (a:Amenidade {tipo: "Hospital"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 5;

MATCH (c:Cliente {nome: "Ana Costa"}), (a:Amenidade {tipo: "Academia"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 4;

MATCH (c:Cliente {nome: "Bruno Alves"}), (a:Amenidade {tipo: "Mercado"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 4;

MATCH (c:Cliente {nome: "Bruno Alves"}), (a:Amenidade {tipo: "Metrô"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 3;

MATCH (c:Cliente {nome: "Carla Mendes"}), (a:Amenidade {tipo: "Ciclovia"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 4;

MATCH (c:Cliente {nome: "Carla Mendes"}), (a:Amenidade {tipo: "Parque"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 4;

MATCH (c:Cliente {nome: "Diego Rocha"}), (a:Amenidade {tipo: "Escola"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 5;

MATCH (c:Cliente {nome: "Diego Rocha"}), (a:Amenidade {tipo: "Mercado"})
MERGE (c)-[p:PREFERE]->(a)
SET p.peso = 3;

// -----------------------------------------------------
// 11) Interações: VISITOU e FEZ_PROPOSTA
// Observação: para evitar duplicar visitas em múltiplas execuções,
// usamos MERGE com chave (data) dentro do relacionamento.
// -----------------------------------------------------
MATCH (c:Cliente {nome: "Maria Silva"}), (i:Imovel {id: 103})
MERGE (c)-[v:VISITOU {data: date("2025-12-10")}]->(i);

MATCH (c:Cliente {nome: "Maria Silva"}), (i:Imovel {id: 108})
MERGE (c)-[v:VISITOU {data: date("2025-12-12")}]->(i);

MATCH (c:Cliente {nome: "João Pereira"}), (i:Imovel {id: 101})
MERGE (c)-[v:VISITOU {data: date("2025-12-08")}]->(i);

MATCH (c:Cliente {nome: "João Pereira"}), (i:Imovel {id: 105})
MERGE (c)-[v:VISITOU {data: date("2025-12-09")}]->(i);

MATCH (c:Cliente {nome: "Ana Costa"}), (i:Imovel {id: 104})
MERGE (c)-[v:VISITOU {data: date("2025-12-05")}]->(i);

MATCH (c:Cliente {nome: "Carla Mendes"}), (i:Imovel {id: 110})
MERGE (c)-[v:VISITOU {data: date("2025-12-11")}]->(i);

MATCH (c:Cliente {nome: "Diego Rocha"}), (i:Imovel {id: 102})
MERGE (c)-[v:VISITOU {data: date("2025-12-07")}]->(i);

// Propostas (idempotentes via MERGE com data + valor)
MATCH (c:Cliente {nome: "Maria Silva"}), (i:Imovel {id: 103})
MERGE (c)-[p:FEZ_PROPOSTA {data: date("2025-12-13"), valor: 760000}]->(i)
SET p.status = "ENVIADA";

MATCH (c:Cliente {nome: "João Pereira"}), (i:Imovel {id: 101})
MERGE (c)-[p:FEZ_PROPOSTA {data: date("2025-12-10"), valor: 440000}]->(i)
SET p.status = "RECUSADA";

MATCH (c:Cliente {nome: "Ana Costa"}), (i:Imovel {id: 104})
MERGE (c)-[p:FEZ_PROPOSTA {data: date("2025-12-06"), valor: 950000}]->(i)
SET p.status = "ACEITA";

// -----------------------------------------------------
// 12) Checagem rápida
// -----------------------------------------------------
MATCH (n)
RETURN labels(n) AS labels, count(*) AS total
ORDER BY total DESC;
