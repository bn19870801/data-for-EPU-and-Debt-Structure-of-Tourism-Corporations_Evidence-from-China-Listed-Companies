********EPU on Tourism Funding 回归部分
clear
cd "D:\EPU_on_Tourism"

  use "D:\EPU_on_Tourism\EPU_on_Tourism.dta"

 xtset id year  //将数据设置为面板数据
 
 reghdfe ll tl i.year, absorb(id)  vce (cluster Sicmen)
 
 order year YEPU
 sort id year
 drop if year
 gen short_debt=A002101000/A002000000
 gen long_debt=A002201000/A002000000
 gen FundingCost=A002114000/A002000000
 replace FundingCost=. if  FundingCost==0
 gen other_shortdebt = sl-short_debt
 gen EPUSENSE_1 = epu_sense_s_1 * YEPU
  gen EPUSENSE_2 = epu_sense_w_1 * YEPU
  gen EPUSENSE_3 = epu_sense_s_1 * YCEPU
  gen EPUSENSE_4 = epu_sense_w_1 * YCEPU
  gen EPUSENSE_5 = epu_sense_s_1 * lnYEPU
  
  replace EPUSENSE_1 = epu_sense_s_1 * YEPU /100
  replace EPUSENSE_2 = epu_sense_w_1 * YEPU /100
  replace EPUSENSE_3 = epu_sense_s_1 * YCEPU /100
  replace EPUSENSE_4 = epu_sense_w_1 * YCEPU /100
 
 
ssc install reghdfe, replace   //用于回归的外部命令包
ssc install ivreg2, replace    //另一种用于回归的外部命令
ssc install outreg2, replace  //输出回归结果到表格

****Table 2 Statistical Summary
outreg2 using stats.doc, replace sum(log) keep(sl short_debt bankd banklev other_shortdebt FC_index SA_index EPUSENSE_1 EPUSENSE_2 EPUSENSE_3 EPUSENSE_4 FundingCost  size tl roa roe tang cflow) title(Decriptive statistics)
 
 ****Table 3 Benchmark Regression
 reghdfe sl EPUSENSE_1 i.year, absorb(id)  vce (cluster Sicmen) 
 outreg2 using main.doc, word replace  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id)  vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_2 i.year, absorb(id)  vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_2 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
  reghdfe sl EPUSENSE_3 i.year, absorb(id)  vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_3 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
   reghdfe sl EPUSENSE_4 i.year, absorb(id)  vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_4 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 reghdfe sl EPUSENSE_1 size tl roa roe tang cflow i.year if Sicmen_str!="G", absorb(id) vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
  reghdfe sl EPUSENSE_1 size tl roa roe tang cflow i.year if year<=2019, absorb(id) vce (cluster Sicmen) 
 outreg2 using main.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 

***Mechanism



***Table 4 sl Decomposition

reghdfe bankd EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)
outreg2 using Decomp.doc, word replace  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)

 reghdfe banklev EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)  
 outreg2 using Decomp.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
  reghdfe Finlev EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)  
 outreg2 using Decomp.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
 
 reghdfe short_debt EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
  outreg2 using Decomp.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
  
 reghdfe other_shortdebt EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
  outreg2 using Decomp.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)

**Table 5 
**Panel A FundingCost
  

	 reghdfe sl c.FundingCost#c.EPUSENSE_1 FundingCost EPUSENSE_1 size tl roa roe tang cflow  i.year, absorb(id) vce (cluster Sicmen)
	 outreg2 using Mechanism_A.doc, word replace  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
	 
	 reghdfe sl c.FundingCost#c.EPUSENSE_2 FundingCost EPUSENSE_2 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
	 outreg2 using Mechanism_A.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
	 
	 reghdfe sl c.FundingCost#c.EPUSENSE_3 FundingCost EPUSENSE_3 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
	 outreg2 using Mechanism_A.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
	 
	 reghdfe sl c.FundingCost#c.EPUSENSE_4 FundingCost EPUSENSE_4 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen) 
	 outreg2 using Mechanism_A.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
  
***Panel B Financial Constraints: FC_index SA_index
  
   reghdfe FC_index EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)
   outreg2 using Mechanism_B.doc, word replace  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
   
 reghdfe FC_index EPUSENSE_2 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)
 outreg2 using Mechanism_B.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
 
    reghdfe SA_index EPUSENSE_1 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)
	outreg2 using Mechanism_B.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
	
 reghdfe SA_index EPUSENSE_2 size tl roa roe tang cflow i.year, absorb(id) vce (cluster Sicmen)
 outreg2 using Mechanism_B.doc, word append  bdec(3) sdec(2) ctitle(FE) cttop(FE) addtext(Company FE, YES, Year FE, YES)
  
  
  
****Heterogeneous

    reghdfe sl EPUSENSE_1 size tl roa roe tang cflow i.year if govcon1==0  , absorb(id) vce (cluster Sicmen)
 reghdfe sl EPUSENSE_1 size tl roa roe tang cflow i.year if govcon1==1, absorb(id) vce (cluster Sicmen)
  
   reghdfe sl EPUSENSE_1 c.EPUSENSE_1#c.invt invt size tl roa roe tang cflow i.year , absorb(id) vce (cluster Sicmen)
  