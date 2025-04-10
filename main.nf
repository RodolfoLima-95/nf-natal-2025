#!/usr/bin/env nextflow
nextflow.enable.dsl=2

file_ch = Channel.fromPath(params.file)


log.info """\
        Bcftools Python Pipeline
        ================================
        Vcf file with variants: ${params.file}
        """
        .stripIndent(true)


        process FILTER {
            tag "Filtrando ${item}"

            input:
            path item

            output:
            path "${item.baseName}.filtered.vcf"

            script:
            """
            bcftools view ${task.ext.args} ${item} > ${item.baseName}.filtered.vcf
            """
        }

        process TABLE {
            tag "Gerando tabela para ${item.baseName}"

            input:
            path item

            output:
            path "${item.baseName}.filtered.tsv"

            script:
            """
            bcftools query -f '%ID\t%CHROM\t%POS\t%INFO/END\t%INFO/SVTYPE\t%INFO/SVLEN\n' ${item} > ${item.baseName}.filtered.tsv
            """
        }

        process PROCESS_TABLE {
            tag "Arquivo variantes.csv gerado"
            publishDir "./results",mode: 'copy'

            input:
            path item

            output:
            path "variantes.${item.baseName}.csv"

            script:
            """
            tabled.py ${item}
            """
        }

workflow {
    results=FILTER(file_ch)
    results_ch=TABLE(results)
    PROCESS_TABLE(results_ch)
}
