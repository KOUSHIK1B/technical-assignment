-- Question 2: SQL and Database

-- A. Number of Acacia plant types

USE Rfam;

SELECT COUNT(DISTINCT species) AS acacia_plant_types
FROM taxonomy
WHERE species LIKE 'Acacia %';


-- B. Wheat type with the longest DNA sequence

SELECT
    t.species AS wheat_type,
    r.length AS dna_sequence_length
FROM rfamseq AS r
JOIN taxonomy AS t
    ON r.ncbi_id = t.ncbi_id
WHERE t.species LIKE 'Triticum %'
  AND r.mol_type LIKE '%DNA%'
ORDER BY r.length DESC
LIMIT 1;


-- C. Families with DNA sequences longer than 1,000,000
-- Page 9, 15 results per page

SELECT
    f.rfam_acc AS family_accession,
    f.rfam_id AS family_name,
    MAX(r.length) AS maximum_dna_sequence_length
FROM family AS f
JOIN full_region AS fr
    ON f.rfam_acc = fr.rfam_acc
JOIN rfamseq AS r
    ON fr.rfamseq_acc = r.rfamseq_acc
WHERE r.mol_type LIKE '%DNA%'
GROUP BY
    f.rfam_acc,
    f.rfam_id
HAVING MAX(r.length) > 1000000
ORDER BY maximum_dna_sequence_length DESC
LIMIT 15 OFFSET 120;