Simple test de l'entity controller. La testbench met tout le temps data à 1 (simule que tous les boutons sont appuyés) et fait varier la clock toutes les 0.5ns (T_clock = 10ns).

state se remplit bien progressivement de 1 entre les deux latch (comme tous les boutons sont appuyés c'est bien le bon comportement).

Note: vous pouvez facilement checker les résultats en téléchargeant GTKWave et en ouvrant waves.ghw (pensez à faire Time > Zoom > Zoom Full).
