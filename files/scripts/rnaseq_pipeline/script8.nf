/*
 * Example showing pipeline modularizaion
 * Author: Paolo Di Tommaso
 */
nextflow.enable.dsl = 2

/*
 * pipeline input parameters
 */
params.reads = "data/yeast/reads/ref1_{1,2}.fq.gz"
params.transcriptome = "data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz"
params.outdir = "results"

log.info """\
         R N A S E Q - N F   P I P E L I N E
         ===================================
         transcriptome: ${params.transcriptome}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


include { RNASEQFLOW } from './modules/rnaseq-flow.nf'

workflow {
    read_pairs_ch = Channel.fromFilePairs( params.reads, checkIfExists:true )
    RNASEQFLOW( params.transcriptome, read_pairs_ch )
}
