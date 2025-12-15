# DNA methylation signature of cognitive reserve moderates CSF tau pathology in prodromal Alzheimer’s disease
David Lukacsovich, Juan I. Young, Lissette Gomez, Brian W. Kunkle, Zhixin Mao, Wei Zhang, X. Steven Chen, Deirdre M. O’Shea, Tatjana Rundek, Eden R. Martin, Lily Wang

### Description

This GitHub repository includes scripts used for the analyses in the above manuscript. 

Cognitive reserve (CR) refers to differences in the adaptability of cognitive processes that modify the impact of Alzheimer’s disease (AD) pathology on cognitive performance.  Currently there are no established blood-based biomarkers of CR in prodromal AD. In this study, we operationalize CR as memory reserve, defined as moderation (attenuation) of the CSF pTau181-memory association. DNA methylation (DNAm) integrates genetic and environmental influences and may capture biological processes that mitigate the impact of AD pathology on memory. We aimed to identify blood DNAm loci that moderate the association between cerebrospinal fluid (CSF) phosphorylated tau (pTau181) and memory in mild cognitive impairment (MCI). We also sought to determine if a DNAm-based signature of memory reserve predicts future memory decline. 

### 0. Get list of amyloid positive samples to run analysis on
| File                  | Link |
|----------------------|-------------|
| code/markdown/00_get_target_samples | [Link to the script](https://github.com/TransBioInfoLab/AD_CR/blob/main/code/markdown/00_get_target_samples.Rmd) |

### 1. Pre-processing DNA methylation data

| File                 | Dataset | Link |
|----------------------|-------------|-------------|
| code/markdown/01a_prepare_BDR_data.Rmd        |   BDR  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01a_prepare_BDR_data.Rmd) |
| code/markdown/01a_prepare_Rosmap_data.Rmd         |   Rosmap  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01a_prepare_Rosmap_data.Rmd) |
| code/markdown/01b_preprocess_BDR_data.Rmd        |   BDR  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01b_preprocess_BDR_data.Rmd) |
| code/markdown/01b_preprocess_Rosmap_data.Rmd         |   Rosmap  | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/01b_preprocess_Rosmap_data.Rmd) |

### 2. Single cohort and meta-analysis

| File                 | Link |
|----------------------|-------------|
| code/markdown/02a_associate_data.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02a_associate_data.Rmd) |
| code/markdown/02b_association_meta_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02b_association_meta_analysis.Rmd) |
| code/markdown/02c_association_signif_probes.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/02c_association_signif_probes.Rmd) |

### 3. DMR and enrichment analyses  

| File                 | Link |
|----------------------|-------------|
| code/markdown/03a_cometh_dmr.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03a_cometh_dmr.Rmd) |
| code/markdown/03b_cometh_dmr_meta_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03b_cometh_dmr_meta_analysis.Rmd) |
| code/markdown/03c_Annotate_combp.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03c_Annotate_combp.Rmd) |
| code/markdown/03d_merge_cometh_dmr_combp.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03d_merge_cometh_dmr_combp.Rmd) |
| code/markdown/03e_enrichment_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03e_pathway_analysis.Rmd ) |
| code/markdown/03f_enrichment_analysis_figures.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/03f_pathway_analysis_figures.Rmd) |

### 4. Correlation of aging-associated CpGs and DMRs methylation levels in blood and brain samples  

| File                 | Link |
|----------------------|-------------|
| code/markdown/04a_brain_blood_correlation.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/04a_brain_blood_correlation.Rmd) |

### 5. Correlation between aging-associated DNAm with expressions of nearby genes 

| File                 | Link |
|----------------------|-------------|
| code/markdown/05a_get_DNAm_Data.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05a_get_DNAm_Data.Rmd) |
| code/markdown/05b_preprocess_DNAm_Data.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05b_preprocess_DNAm_Data.Rmd) |
| code/markdown/05c_get_DNAm_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05c_get_DNAm_residuals.Rmd) |
| code/markdown/05d_get_DMR_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05d_get_DMR_residuals.Rmd) |
| code/markdown/05e_get_RNA_residuals.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05e_get_RNA_residuals.Rmd) |
| code/markdown/05f_associate_RNA_to_DNAm.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05f_associate_RNA_to_DNAm.Rmd) |
| code/markdown/05g_sensitivity_analysis.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/05g_evaluate_association_consistency.Rmd) |

### 6. Validation against external datasets
| File                 | Link |
|----------------------|-------------|
| code/markdown/07a_check_against_miamiad_ad.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/07a_check_against_miamiad_ad.Rmd) |
| code/markdown/07b_annotate_cox_markers.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/07b_annotate_cox_markers.Rmd) |

### 7. Creating figures

| File                 | Link |
|----------------------|-------------|
| code/markdown/06a_aging_vs_ad_miami.Rmd       |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06a_aging_vs_ad_miami.Rmd) |
| code/markdown/06b_venn_diagram.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06b_venn_diagram.Rmd) |
| code/markdown/06c_epigenetic_association.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06c_epigenetic_association.Rmd) |
| code/markdown/06d_check_against_miamiad.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06d_check_against_miamiad.Rmd) |
| code/markdown/06e_get_matched_samples.Rmd      |  [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/06e_get_matched_samples.Rmd) |
| code/markdown/07c_MRS_KM_Plots.Rmd               | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/07c_MRS_KM_Plots.Rmd) |
| code/markdown/07d_MRS_Residual_Plots.Rmd               | [Link to the script](https://github.com/TransBioInfoLab/AD-aging-brain-samples-analysis/blob/main/code/markdown/07d_MRS_Residual_Plots.Rmd) |
