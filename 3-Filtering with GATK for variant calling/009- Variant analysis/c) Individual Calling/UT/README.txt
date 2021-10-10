#################################################
## Unit Test for 003 stage of mk-gatk pipeline ##

##### FIRST UNIT TEST	#####
This unit test performs a VCF validation of the .g.vcf files.
It uses the "vcf_validator" tool developed at:

 https://github.com/cyenyxe/vcf-validator

NOTE: since this module produces a g.vcf, the format is different from a traditional vcf, as explained at:

https://gatkforums.broadinstitute.org/gatk/discussion/4017/what-is-a-gvcf-and-how-is-it-different-from-a-regular-vcf

Because of that, the module only logs the oddities proper of a g.vcf.

#####	SECOND UNIT TEST	#####

This test performs vcf file validation according to:

https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_gatk_tools_walkers_variantutils_ValidateVariants.php#--validateGVCF

This test takes into account the oddities of a gvcf produced by GATK
