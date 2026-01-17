# DNA methylation signature of cognitive reserve moderates CSF tau pathology in prodromal Alzheimer’s disease
David Lukacsovich, Juan I. Young, Lissette Gomez, Brian W. Kunkle, Zhixin Mao, Wei Zhang, X. Steven Chen, Deirdre M. O’Shea, Tatjana Rundek, Eden R. Martin, Lily Wang

### Description

This GitHub repository includes scripts used for the analyses in the above manuscript. 

Cognitive reserve (CR) refers to differences in the adaptability of cognitive processes that modify the impact of Alzheimer’s disease (AD) pathology on cognitive performance.  Currently there are no established blood-based biomarkers of CR in prodromal AD. In this study, we operationalize CR as memory reserve, defined as moderation (attenuation) of the CSF pTau181-memory association. DNA methylation (DNAm) integrates genetic and environmental influences and may capture biological processes that mitigate the impact of AD pathology on memory. We aimed to identify blood DNAm loci that moderate the association between cerebrospinal fluid (CSF) phosphorylated tau (pTau181) and memory in mild cognitive impairment (MCI). We also sought to determine if a DNAm-based signature of memory reserve predicts future memory decline. 

### 0. Prepare amyloid positive samples 
| File                  | Link |
|----------------------|-------------|
| code/markdown/00_get_target_samples | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/00_get_target_samples.Rmd) |

### 1. Pre-processing DNA methylation data

| File                 | Link |
|----------------------|-------------|
| code/markdown/01a_get_data.Rmd                 | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01a_get_data.Rmd) |
| code/markdown/01b_filter_probes.Rmd            | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01b_filter_probes.Rmd) |
| code/markdown/01c_impute_autosomal.Rmd         | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01c_impute_autosomal.Rmd) |
| code/markdown/01d_normalize_autosomal.Rmd      | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01d_normalize_autosomal.Rmd) |
| code/markdown/01e_pca_autosomal.Rmd            | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01e_pca_autosomal.Rmd) |
| code/markdown/01f_batch_autosomal.Rmd          | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01f_batch_autosomal.Rmd) |
| code/markdown/01g_batch_kw_plots.Rmd           | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01g_batch_kw_plots.Rmd) |
| code/markdown/01h_compile_characteristics.Rmd  | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/01h_compile_characteristics.Rmd) |

### 2. Identify memory reserve-related CpGs and DMRs   

| File                 | Link |
|----------------------|-------------|
| code/markdown/02a_mem_correlation.Rmd         | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02a_mem_correlation.Rmd) |
| code/markdown/02b_bacon_correct.Rmd           | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02b_bacon_correct.Rmd) |
| code/markdown/02c_get_signif_table.Rmd        | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02c_get_signif_table.Rmd) |
| code/markdown/02d_prepare_combp.Rmd           | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02d_prepare_combp.Rmd) |
| code/markdown/02e_summarise_combp.Rmd         | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02e_summarise_combp.Rmd) |
| code/markdown/02f_sig_betavals.Rmd            | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02f_sig_betavals.Rmd) |
| code/markdown/02g_get_miami_ad_statistics.Rmd | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/02g_get_miami_ad_statistics.Rmd) |
| summary statistics for CR-associated DNAm     |     |
### 3. Integrative analyses (pathway analysis, eQTm, brain-blood DNAm correlations)  

| File                 | Link |
|----------------------|-------------|
| code/markdown/03a_pathway_analysis.Rmd        | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/03a_pathway_analysis.Rmd) |
| code/markdown/03b_eQTM_association.Rmd        | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/03b_eQTM_association.Rmd) |
| code/markdown/03c_brain_blood_correlation.Rmd | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/03c_brain_blood_correlation.Rmd) |

### 4. Figures

| File                 | Link |
|----------------------|-------------|
| code/markdown/04a_miami_plot.Rmd              | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/04a_miami_plot.Rmd) |
| No association between DNAm vs. pTau or memory (DMRs)  | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/04b_dmr_plots.Rmd) |
| No association between DNAm vs. pTau or memory (CpGs)  | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/_DNAm_pTau_interaction_plots_MCI_12-14-2025.Rmd) |

### 5. Sensitivity analysis that additionally adjusts smoking status

| File                 | Link |
|----------------------|-------------|
| code/markdown/05a_mem_correlation.Rmd         | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/05a_mem_correlation.Rmd) |
| code/markdown/05b_bacon_correct.Rmd           | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/05b_bacon_correct.Rmd) |
| code/markdown/05c_prepare_combp.Rmd           | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/05c_prepare_combp.Rmd) |
| code/markdown/05d_summarize_combp.Rmd         | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/05d_summarize_combp.Rmd) |
| code/markdown/05e_get_smoking_summaries.Rmd   | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/05e_get_smoking_summaries.Rmd) |

### 5. Methylation-based Reserve Scores

| File                 | Link |
|----------------------|-------------|
| compute MRS   | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/_compute_mrs_MCI_11-1-2025.Rmd) |
| MRS predicts future visits  | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/_ADNI-future-visits-PHC-MEM_MCI-Z-score-MRS_11-11-2025.Rmd) |




