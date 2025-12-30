function top-comandos
    set -l un_ano_atras (date -d "1 year ago" +%s)
    cat ~/.local/share/fish/fish_history | awk -v desde="$un_ano_atras" '
        /^- cmd:/ { 
            split($0, parts, " ");
            current_cmd = parts[3]; 
        }
        /^[ ]+when:/ {
            split($0, t, ": ");
            if (t[2] > desde) {
                if (current_cmd !~ /^history/ && current_cmd !~ /^awk/ && current_cmd != "" && current_cmd != "set") {
                    CMD[current_cmd]++;
                    total++;
                }
            }
        }
        END {
            if (total == 0) { print "No hay datos."; exit; }
            for (c in CMD) {
                pct = (CMD[c]/total)*100;
                num_hashes = int(pct / 2);
                if (num_hashes > 20) num_hashes = 20;
                bar = "";
                for (i=1; i<=20; i++) bar = bar (i <= num_hashes ? "█" : "░");
                printf "%-15.15s %s %6.2f%% (%d veces)\n", c, bar, pct, CMD[c]
            }
        }' | sort -rnk3 | head -n 20
end
