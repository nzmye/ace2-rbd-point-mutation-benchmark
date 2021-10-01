#!/bin/csh
#05-2021, Eda Samiloglu

####
#This script was prepared for produce FoldX-water models and scores of interface mutations of 6m0j complex (263 mutations as total). 
#This script consist from 2 parts; 
#	-Model generation and energy (∆G) calculation
#	-Rename otuput files (.pdb, .foldx, .fxout)
#
#Necessary files: 6m0j.pdb, individual_list.txt, case_identifier
# Usage: ./run.FoldXwater.csh
#Note: Do not forget change the FoldX software directory path if you use the script on your computer.
####

#### MODEL GENERATION, ENERGY CALCULATION #### 
#
# FoldX commands: Repair, BuildModel, AnalyseComplex with water
# Folder organization: Output_structures, Output_scores, Output_files_fxout
#
###############################################

#Do not forget change the FoldX software directory path if you use the script on your computer.
set foldx_dir = "/archive/karacalabshared/Software/foldx5Linux64"

$foldx_dir/foldx --command=RepairPDB --pdb=6m0j.pdb

$foldx_dir/foldx --pdb=6m0j_Repair.pdb --command=BuildModel --mutant-file=individual_list.txt

foreach i (*pdb)
set name = `echo $i | sed 's/\.pdb//g'`
$foldx_dir/foldx --pdb="$name".pdb --command=AnalyseComplex --analyseComplexChains=A,E --pdbWaters=true --water=-PREDICT > "$name".foldx
end

mkdir Output_structures
mkdir Output_scores
mkdir Output_files_fxout

mv *pdb Output_structures
mv *foldx Output_scores
mv *fxout Output_files_fxout 

rm rotabase.txt Unrecognized_molecules.txt
rm -r molecules

#### RENAME the FILES #### 
#Rename strucuture, foldx, other files respectively
#case_identifier file generated by using HADDOCK_Prepared_dataset file (first 4 column) to rename files properly.
###############################################

cd Output_structures 

cp ../case_identifier . 
cp ../individual_list.txt .
sed 1d case_identifier > case_identifier2

ls 6m0j_Repair_*.pdb |sort -V > MUT_names_list
ls WT_6m0j_Repair_*.pdb |sort -V > WT_names_list


#Mutant .pdbs

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT.pdb"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type .pdbs
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT.pdb"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

rm case_identifier* matched_name_lines individual_list.txt tmp* WT_names_list MUT_names_list

cd ../Output_scores

cp ../case_identifier . 
cp ../individual_list.txt .
sed 1d case_identifier > case_identifier2

ls 6m0j_Repair_*.foldx |sort -V > MUT_names_list
ls WT_6m0j_Repair_*.foldx |sort -V > WT_names_list

#Mutant .foldx

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT.foldx"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type .foldx
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT.foldx"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

rm case_identifier* matched_name_lines individual_list.txt tmp* WT_names_list MUT_names_list

#Output_files_fxout: There are 4 typs files; Individual energy, Interface residues, Interaction and Summary for both mutants and wild-types.

cd ../Output_files_fxout

cp ../case_identifier . 
cp ../individual_list.txt .
sed 1d case_identifier > case_identifier2

# 1-Individual energy

ls Indiv_energies_6m0j_Repair_*_AC* |sort -V > MUT_names_list
ls Indiv_energies_WT_6m0j_Repair_*_AC* | sort -V > WT_names_list

#Mutant

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT_Indiv_energies.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT_Indiv_energies.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

# 2-Interface residues

ls Interface_Residues_6m0j_Repair_*_AC* |sort -V > MUT_names_list
ls Interface_Residues_WT_6m0j_Repair_*_AC* | sort -V > WT_names_list

#Mutant

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT_Interface_Residues.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT_Interface_Residues.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

# 3-Interaction

ls Interaction_6m0j_Repair_*_AC* |sort -V > MUT_names_list
ls Interaction_WT_6m0j_Repair_*_AC* | sort -V > WT_names_list

#Mutant

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT_Interaction.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT_Interaction.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

# 4-Summary

ls Summary_6m0j_Repair_*_AC* |sort -V > MUT_names_list
ls Summary_WT_6m0j_Repair_*_AC* | sort -V > WT_names_list

#Mutant

paste -d" " case_identifier2 individual_list.txt MUT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_MUT_Summary.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

#Wild type
paste -d" " case_identifier2 individual_list.txt WT_names_list > matched_name_lines
sed -i 's/ /-/g' matched_name_lines

foreach i(`cat matched_name_lines`)
    echo $i > tmp
    sed -i 's/-/ /g' tmp
    awk '{print $1,$2,$3}' tmp > tmp1
    sed -i 's/ /_/g' tmp1
    set name  = `awk '{print $0}' tmp1`"_FoldXwater_WT_Summary.fxout"

    awk '{print $5}' tmp > tmp2
    set old_name = `awk '{print $0}' tmp2`
    mv $old_name $name
end

rm case_identifier* matched_name_lines individual_list.txt tmp* WT_names_list MUT_names_list 