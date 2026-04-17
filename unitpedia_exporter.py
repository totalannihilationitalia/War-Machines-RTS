import os
import re
import csv

UNITS_DIR = "units"
OUTPUT_FILE = "unitpedia_data.csv"

# Configurazione variabili da estrarre
VARIABLES_TO_EXTRACT = [
    ("name", "nome_unita"),
    ("description", "descrizione"),
    ("buildcostenergy", "costo_energia"),
    ("buildcostmetal", "costo_metallo"),
    ("buildtime", "tempo_costruzione"),
    ("maxdamage", "salute"),
    ("workertime", "potere_costruttivo"),
    ("ExtractsMetal", "estrazione_metallo"),
    ("buildpic", "immagine"),
    ("builder", "e_costruttore"),
    ("category", "categoria"),
]

def clean_lua_comments(content):
    # Rimuove commenti -- e blocchi --[[ ]]
    content = re.sub(r'--\[\[.*?\]\]', '', content, flags=re.DOTALL)
    content = re.sub(r'--.*', '', content)
    return content

def extract_build_options(content):
    # Cerca il blocco buildoptions = { ... } e estrae i nomi tra virgolette
    match = re.search(r'buildoptions\s*=\s*\{(.*?)\}', content, re.DOTALL | re.IGNORECASE)
    if match:
        options_block = match.group(1)
        options = re.findall(r'["\']([a-zA-Z0-9_]+)["\']', options_block)
        return "|".join(options) # Uso il pipe | come separatore per il CSV
    return ""

def parse_lua_unit(file_content):
    unit_data = {}
    clean_content = clean_lua_comments(file_content)

    # 1. Trova l'ID dell'unità (gestisce: id = {, ["id"] = {, 'id' = {)
    id_match = re.search(r'(?:["\']?([a-zA-Z0-9_]+)["\']?)\s*=\s*\{', clean_content.split('return', 1)[-1])
    if id_match:
        unit_id = id_match.group(1).lower()
        if unit_id in ['featuredefs', 'sounds', 'weapons', 'customparams']:
             return None
        unit_data['unit_id'] = unit_id
    else:
        return None

    # 2. Estrai variabili standard
    for lua_var, label in VARIABLES_TO_EXTRACT:
        pattern = rf'{lua_var}\s*=\s*(?:"([^"]*)"|([^, \n}}]+))'
        match = re.search(pattern, clean_content, re.IGNORECASE)
        if match:
            val = match.group(1) if match.group(1) is not None else match.group(2)
            unit_data[label] = val.strip().replace('"', '')
        else:
            unit_data[label] = ""

    # 3. Estrai Build Options (Cosa può costruire)
    unit_data['puo_costruire'] = extract_build_options(clean_content)

    return unit_data

def main():
    all_units = []
    
    if not os.path.exists(UNITS_DIR):
        print(f"Errore: Cartella '{UNITS_DIR}' non trovata.")
        return

    print("Scansione ricorsiva cartelle in corso...")

    # os.walk permette di entrare in tutte le sottocartelle
    for root, dirs, files in os.walk(UNITS_DIR):
        for filename in files:
            if filename.endswith(".lua"):
                filepath = os.path.join(root, filename)
                try:
                    with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
                        content = f.read()
                        data = parse_lua_unit(content)
                        if data and data.get('unit_id'):
                            all_units.append(data)
                            print(f"Trovata: {data['unit_id']} in {os.path.relpath(filepath, UNITS_DIR)}")
                except Exception as e:
                    print(f"Errore nel file {filename}: {e}")

    if all_units:
        # Aggiungiamo 'puo_costruire' alle colonne del CSV
        headers = ["unit_id"] + [v[1] for v in VARIABLES_TO_EXTRACT] + ["puo_costruire"]
        with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as output_file:
            dict_writer = csv.DictWriter(output_file, fieldnames=headers)
            dict_writer.writeheader()
            dict_writer.writerows(all_units)
        print(f"\nCOMPLETATO: {len(all_units)} unità esportate in {OUTPUT_FILE}")
    else:
        print("\nNessun dato trovato. Verifica la struttura dei file .lua")

if __name__ == "__main__":
    main()