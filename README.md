# Nextflow pipleline bcftools
## nf-natal-2025
O presente repositório guarda um pipeline voltado para o processamento de dados de chamada de variantes para sua conversão em arquivo vcf devidamente formatado. 
Ele passa as funções do bcftools, view e query, para filtragem e seleção da informação, seguida de um processo em python para anotação de características e saída como o 
variantes.vcf. 
O pipeline é composto por três módulos que rodam com duas imagens singularity e um arquivo auxiliar python. 


### Arquivos
* main.nf - Aquivo de execução dos módulos.
* nextflow.config - Definição dos containers de execução e do arquivo de teste.
* table.py - Arquivo python que realização anotações nas variantes. 

**Execução dos processos** 
```
nextflow run main.nf --file HG00159.vcf
```
![Organograma](flowchat.png)

[Anexos do pipeline](https://drive.google.com/drive/folders/1FgwljxwUHdLBMAhdYygl3-RxAFDvBq-A?usp=drive_link)
No seguinte anexo existe um folder no google drive com as duas imagens utilizadas, o arquivo defoult para teste (HG00160.vcf) já settado no nextflow.config, e o arquivo para uso em situação real (HG00159.vcf).
