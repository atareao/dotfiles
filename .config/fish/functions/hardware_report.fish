function hardware_report
    echo "--- REPORTE DE SOBERANÍA DIGITAL ---" > hardware.txt
    echo "Fecha: "(date) >> hardware.txt
    echo "--- SYSTEM ---" >> hardware.txt
    fastfetch --pipe >> hardware.txt
    echo "--- GPU DETAIL ---" >> hardware.txt
    lspci | grep -i vga >> hardware.txt
    echo "Reporte generado. ¡Listo para optimizar!"
end
