#################################################
## Unit Test for 004 stage of mk-gatk pipeline ##

##### FIRST UNIT TEST	#####
This unit test performs a VCF validation of the .vcf files.
It uses the "vcf_validator" tool developed at:

 https://github.com/cyenyxe/vcf-validator

#####	SECOND UNIT TEST	#####

This test performs vcf file validation according to:

https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_gatk_tools_walkers_variantutils_ValidateVariants.php#--validateGVCF


#####	THIRD UNIT TEST	#####
This unit test evaluates sensibility and specificity of variant caling, using a reference vcf defined at ./config.mk

Test is performed using GATK VariantEval too:

https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_gatk_tools_walkers_varianteval_VariantEval.php
