########################################################################################################
#### Snakemake pipeline to call variants using GATK4 and annotate said vaariants using SNPEff ##########
####                                                                                          ##########
#### Packages include:                                                                        ##########
#### bwa versiom ???                                                                          ##########
#### samtools version ???                                                                     ##########
########################################################################################################
# clone conda environment here: ????
# Need help or have a query please email me: tsewell000@gmail.com

DATASETS = ["DRR016125", "DRR016140"]

rule all:
  input: expand("quants/{dataset}/quant.sf", dataset=DATASETS)

rule salmon_quant:
    input:
        r1 = "fastq/{sample}_1.fastq.gz",
        r2 = "fastq/{sample}_2.fastq.gz",
        index = "/Users/tsewell/snakemake_RNA/athal_index"
    output:
        "quants/{sample}/quant.sf"
    params:
        dir = "quants/{sample}"
    shell:
        "{SALMON} quant -i {input.index} -l A -p 6 --validateMappings \
         --gcBias --numGibbsSamples 20 -o {params.dir} \
         -1 {input.r1} -2 {input.r2}"