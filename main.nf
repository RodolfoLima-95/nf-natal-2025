#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.file = "HG00160.vcf"
params.script = "tabled.py"
script_ch = Channel.fromPath(params.script)
file_ch = Channel.fromPath(params.file)

process FILTER {
    tag "Filtrando ${item}"

    input:
    path item

    output:
    path 'sample.filtered.*'

    script:
    """
    bcftools view -i 'DP >= 20 && MAPQ >= 40 && FILTER == "PASS"' ${item} > sample.filtered.vcf
    """
}

process TABLE {
    tag "Gerando tabela para ${item}"

    input:
    path item

    output:
    path 'sample.filtered.*'

    script:
    """
    bcftools query -f '%ID\t%CHROM\t%POS\t%INFO/END\t%INFO/SVTYPE\t%INFO/SVLEN\n' ${item} > sample.filtered.tsv
    """
}

process PROCESS_TABLE {
    tag "Arquivo variantes.csv gerado"
    publishDir "./results",mode: 'copy'
    input:
    path item
    path script

    output:
    path 'variantes.*'

    script:
    """
    python3 ${script} ${item}
    """
}

workflow {
    results=FILTER(file_ch)
    results_ch=TABLE(results)
    PROCESS_TABLE(results_ch,script_ch)
}
