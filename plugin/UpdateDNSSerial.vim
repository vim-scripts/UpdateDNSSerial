function! UpdateDNSSerialZone()
        " Initialisation des variables
        let serialZone=0
        let serialZoneUpdated=0
        "Numéro de ligne du timestamp
        let numberOfLine = search(".*".strftime("%Y")."[1-12][1-31][0-99].*")
        "Récupération de la ligne du timestamp DNS
        let line = getline(numberOfLine)
        "Extraction du serial de la zone dans la ligne
        let serialZone=strpart(line, match(line,strftime("%Y")."[1-12][1-31][0-99].*"),match(line,";")-1-match(line,,strftime("%Y")."[1-12][1-31][0-99].*"))
        "Composition du nouveau serial par défaut pour le jour
        let serialZoneUpdated=strftime("%Y%m%d")."01"
       

        "Comparaison des serials
        if serialZone =~ "^".strftime("%Y%m%d").".*"
                " Si date du jour, on incrémente
                let serialZoneUpdated=serialZone+1
                "echo "1 Old serial zone: ".serialZone
                "echo "1 Update serial zone: ".serialZoneUpdated
        endif
        "Nouvelle ligne à insérer
        let line = "                                    ".serialZoneUpdated." ;serial"
        "Modification de la ligne
        call setline(numberOfLine, line)
endfunction

