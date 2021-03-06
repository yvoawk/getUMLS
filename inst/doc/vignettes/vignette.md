How to use {getUMLS} ?
================
Yvon K. AWUKLU
2021-08-07

``` r
library(getUMLS)
```
For use this package, you will need an <span style="color: red">UMLS license</span>. If you do not have a UMLS account, you may apply for a license on the [UMLS Terminology Services (UTS) website](https://uts.nlm.nih.gov/).
## 1. Authentication : UMLS TICKET-GRANT TICKET

First, you need to authentify yourself in order to have access to UMLS
REST API. This function help you to do that. It receives in argument the **apikey** received by UMLS.

``` r
getUMLS::umls_pass()
```

     Access granted.

## 2. Retrieves information about a known CUI

This function provides you a way to retrieve information (name, semantic
types, number of atoms, etc) for a known CUI from latest UMLS version.
It receives as argument a **CUI**.

``` r
getUMLS::fromCUI(CUI = "C0018689")
```

    ## # A tibble: 1 x 6
    ##   name                     type    id      semanticType  atomCount relationCount
    ##   <chr>                    <chr>   <chr>   <chr>             <int>         <int>
    ## 1 Health Care (MeSH Categ… Concept C00186… Classificati…         1             2

## 3. Atoms et Information

The first function provides you a way to retrieve atoms and information about
atoms for a known CUI. It receives as argument a **CUI**, a
UMLS sources vocabularies (optional), a language (optional) and the page
size (optional). You can consult the allowed vocabularies on:
[vocabulary](https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html).

The second function provides you a way to retrieve information about
atoms for a known AUI. It receives as argument a **AUI**.

``` r
getUMLS::atomsfromCUI(CUI = "C0018689")

getUMLS::CUIfromAtoms(AUI = "A8345234")
```

    ##                          name termType rootSource      id
    ## 1 Health Care (MeSH Category)       HT        MSH U000008

## 4. CUI Definition

This function provides you a way to retrieve the source-asserted
definitions for a known CUI. It receives as argument a
**CUI**.

``` r
getUMLS::defromCUI(CUI = "C0155502")
```

    ##    classType sourceOriginated rootSource
    ## 1 Definition             TRUE        MSH
    ## 2 Definition             TRUE     MSHPOR
    ## 3 Definition             TRUE     MSHCZE
    ##                                                                                                                                                                                                                                                   value
    ## 1  Idiopathic recurrent VERTIGO associated with POSITIONAL NYSTAGMUS. It is associated with a vestibular loss without other neurological or auditory signs. Unlike in LABYRINTHITIS and VESTIBULAR NEURONITIS, inflammation in the ear is not observed.
    ## 2 VERTIGEM idiopática recorrente associada com NISTAGMO FISIOLÓGICO. Está associada com uma perda vestibular sem outros sinais neurológicos ou auditivos. Diferentemente da LABIRINTITE e da NEURONITE VESTIBULAR, não se observa inflamação na ouvido.
    ## 3                                                        Idiopatické rekurentní vertigo spojené s polohovým nystagmem. Je způsobené poruchou vestibulárního aparátu. Na rozdíl od labyrintitidy a vestibulární neuronitidy se neprojevuje zánětem ucha.

## 5. CUI Relation

This function provides you a way to retrieve the NLM-asserted
relationships for a known CUI. It receives as argument a
**CUI** and the pageSize (optional).

``` r
getUMLS::relfromCUI(CUI = "C0155502")
```

    ##         id                                                relatedIdName
    ## 1 C0042571                                                      Vertigo
    ## 2 C0155501                                          Vertigo, Peripheral
    ## 3 C0494557                                    Benign paroxysmal vertigo
    ## 4 C0522351                                           Positional Vertigo
    ## 5 C0022890                                        Labyrinthine disorder
    ## 6 C0153113                              Acute Peripheral Vestibulopathy
    ## 7 C0302851                                              Cupulolithiasis
    ## 8 C2239166 (Labyrinthine disorders NOS) or (vertigo, benign positional)
    ##   rootSource        ui
    ## 1        MTH R02886477
    ## 2        MTH R13332710
    ## 3        MTH R02946952
    ## 4        MTH R44194411
    ## 5        MTH R29933744
    ## 6        MTH R03377694
    ## 7        MTH R03266972
    ## 8        MTH R91960384

## 6. ID from String

This function provides you a way to retrieve a source-asserted
identifiers (**codes**) associate with a search term (**string**) in
UMLS specific source vocabulary. You can consult the allowed
vocabularies on:
[vocabulary](https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html).

``` r
getUMLS::IdfromString(String = "bone fracture", vocabulary = "MSH")
```

    ## [1] "D050723"

## 7. CUI from String

This function provides you a way to retrieve a UMLS Concept Unique
Identifier (**CUI**) associate with a search term (**string**).

``` r
getUMLS::CUIfromString(String = "bone fracture")
```

    ## [1] "C0016658"

## 8. CUI from another source-asserted identifier

This function provides you a way to retrieve a UMLS Concept Unique
Identifier (**CUI**) associate with a specific source-asserted
identifier (**code**). It receives as argument a **Id**
(source-asserted identifier) and a **vocabulary** abbreviation (source
vocabulary). You can consult the allowed vocabularies on:
[vocabulary](https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html).

``` r
getUMLS::CUIfromId(Id = "J45", vocabulary = "ICD10")
```

    ## [1] "C0004096"

## 9. Hierarchical information

This function provides you a way to retrieve a hierarchical information
about a known source-asserted identifier. You can : 
> * Retrieve the immediate parents of a known source asserted identifier. 
> * Retrieve all immediate children of a known source asserted identifier. 
> * Retrieve all ancestors or descendants of a known source asserted identifier.

``` r
getUMLS::hierarchyfromSource(vocabulary = "ICD10", Id = "J45", type = "children")
```

    ## result                                            
    ## 1 Asthma, unspecified          
    ## 2 Predominantly allergic asthma
    ## 3 Nonallergic asthma           
    ## 4 Mixed asthma  

## Reference

« UMLS REST API Home Page ».
<https://documentation.uts.nlm.nih.gov/rest/home.html>
