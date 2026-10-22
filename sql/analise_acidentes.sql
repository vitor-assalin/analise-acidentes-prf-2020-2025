
-- Projeto: Análise de Acidentes em Rodovias Federais Brasileiras
-- Fonte: Polícia Rodoviária Federal (PRF)
-- Período: 2020 a 2025
-- Ferramenta: DuckDB

-- 1. Evolução anual dos acidentes e das mortes
SELECT
    ano,
    COUNT(*) AS total_acidentes,
    SUM(COALESCE(mortos, 0)) AS total_mortes
FROM acidentes
GROUP BY ano
ORDER BY ano;


-- 2. Principais causas por número de mortes
-- Comparação de causas delimitada a 2021-2025.
SELECT
    causa_acidente,
    COUNT(*) AS total_acidentes,
    SUM(COALESCE(mortos, 0)) AS total_mortes
FROM acidentes
WHERE ano BETWEEN 2021 AND 2025
GROUP BY causa_acidente
ORDER BY total_mortes DESC
LIMIT 10;


-- 3. Acidentes classificados como fatais por UF
-- Representa registros de acidentes, não pessoas mortas.
SELECT
    uf,
    COUNT(*) AS acidentes_fatais
FROM acidentes
WHERE classificacao_acidente = 'Com Vítimas Fatais'
GROUP BY uf
ORDER BY acidentes_fatais DESC;


-- 4. Evolução anual das mortes associadas às três causas selecionadas
SELECT
    ano,
    causa_acidente,
    COUNT(*) AS total_acidentes,
    SUM(COALESCE(mortos, 0)) AS total_mortes
FROM acidentes
WHERE ano BETWEEN 2021 AND 2025
  AND (
      causa_acidente ILIKE '%ausência de reação%'
      OR causa_acidente ILIKE '%contramão%'
      OR causa_acidente ILIKE '%velocidade incompatível%'
  )
GROUP BY ano, causa_acidente
ORDER BY ano, total_mortes DESC;
