gmx grompp  -v -f mdp/em-solute.mdp -c input-MD.gro -p run.top -o em-whole.tpr
gmx mdrun -v -deffnm em-whole  -nb gpu
##################  solute-relaxed-600 ######################
cp posre-600.itp posre.itp
cp posre-ligand-600.itp posre-ligand.itp
gmx grompp  -v -f mdp/em-solute.mdp -c em-whole.gro -p run.top -o em-600.tpr
gmx mdrun -v -deffnm em-600 -nb gpu
##################  solute-relaxed-300 ######################
cp posre-300.itp posre.itp
cp posre-ligand-300.itp posre-ligand.itp
gmx grompp  -v -f mdp/em-solute.mdp -c em-600.gro -p run.top -o em-300.tpr
gmx mdrun -v -deffnm em-300  -nb gpu
##################  solute-relaxed-0 ######################
gmx grompp  -v -f mdp/em-0.mdp -c em-300.gro -p run.top -o em-0.tpr
gmx mdrun -v -deffnm em-0 -nb gpu
cp posre-1000.itp posre.itp
cp posre-ligand-1000.itp posre-ligand.itp
gmx grompp  -v -f mdp/heat.mdp -c em-0.gro -p run.top -o heat.tpr -n -maxwarn 2
gmx mdrun  -v -deffnm heat -nb gpu
################## restraining remove ###############
cp posre-1000.itp posre.itp
cp posre-ligand-1000.itp posre-ligand.itp
gmx grompp  -v -f mdp/restrains.mdp  -c heat.gro  -p run.top -o restrains-1000.tpr -maxwarn 2 -n -t heat.cpt
gmx mdrun  -v -deffnm restrains-1000 -nb gpu
cp posre-600.itp posre.itp
cp posre-ligand-600.itp posre-ligand.itp
gmx grompp  -v -f mdp/restrains.mdp  -c restrains-1000.gro  -p run.top -o restrains-600.tpr -maxwarn 2 -n -t restrains-1000.cpt
gmx mdrun  -v -deffnm restrains-600 -nb gpu
cp posre-300.itp posre.itp
cp posre-ligand-300.itp posre-ligand.itp
gmx grompp  -v -f mdp/restrains.mdp  -c restrains-600.gro  -p run.top -o restrains-300.tpr -maxwarn 2 -n -t restrains-600.cpt
gmx mdrun -v -deffnm restrains-300 -nb gpu
################## md simulation ###############
gmx grompp  -v -f mdp/md.mdp   -c restrains-300.gro  -p run.top -o md-1.tpr  -maxwarn 2 -n -t restrains-300.cpt
gmx mdrun  -v -deffnm md-1 -nb gpu
