# luadefs to mysql by molix. free to use

import os
import re
import csv

# --- CONFIGURAZIONE ---
UNITS_DIR = "units"
PICS_DIR = "unitpics" # Cartella dove tieni le immagini per controllare se esistono i background
OUTPUT_FILE = "unitpedia_data.csv"

# Variabili standard da cercare nel file Lua
VARIABLES_TO_EXTRACT = [
    ("name", "nome_unita"),
    ("description", "descrizione"),
    ("buildcostenergy", "costo_energia"),
    ("buildcostmetal", "costo_metallo"),
    ("buildtime", "tempo_costruzione"),
    ("maxdamage", "salute"),
    ("workertime", "potere_costruttivo"),
    ("ExtractsMetal", "estrazione_metallo"),
    ("radardistance", "radar"),
    ("sonardistance", "sonar"),
    ("jammer", "jammer"),
    ("stealth", "stealth"),
    ("buildpic", "immagine"),
    ("builder", "e_costruttore"),
    ("category", "categoria")
]

def clean_lua_comments(content):
    content = re.sub(r'--\[\[.*?\]\]', '', content, flags=re.DOTALL)
    content = re.sub(r'--.*', '', content)
    return content

def extract_build_options(content):
    match = re.search(r'buildoptions\s*=\s*\{(.*?)\}', content, re.DOTALL | re.IGNORECASE)
    if match:
        options_block = match.group(1)
        options = re.findall(r'["\']([a-zA-Z0-9_]+)["\']', options_block)
        return "|".join(options)
    return ""

def find_backgrounds(unit_id):
    """Controlla se esistono file tipo unitid_1.jpg, unitid_2.jpg ecc. nella cartella unitpics"""
    bg_list = []
    # Cerchiamo file .jpg o .png con suffisso _1, _2, _3
    for i in range(1, 4): 
        bg_name = f"{unit_id}_{i}.jpg"
        # Opzionale: decommenta le righe sotto se vuoi che il CSV contenga SOLO file esistenti sul tuo PC
        # if os.path.exists(os.path.join(PICS_DIR, bg_name)):
        #     bg_list.append(bg_name)
        # Per ora le aggiungiamo a prescindere, il PHP le nasconderà se non esistono
        bg_list.append(bg_name)
    return "|".join(bg_list)

def parse_lua_unit(file_content):
    unit_data = {}
    clean_content = clean_lua_comments(file_content)

    # 1. Trova l'ID dell'unità
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

    # 3. Estrai Build Options e Sfondi
    unit_data['puo_costruire'] = extract_build_options(clean_content)
    unit_data['sfondi'] = find_backgrounds(unit_id)

    return unit_data

def main():
    all_units = []
    if not os.path.exists(UNITS_DIR):
        print(f"Errore: Cartella '{UNITS_DIR}' non trovata.")
        return

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
                            print(f"Estratta: {data['unit_id']}")
                except Exception as e:
                    print(f"Errore in {filename}: {e}")

    if all_units:
        # Intestazioni CSV: unit_id + label variabili + puo_costruire + sfondi
        headers = ["unit_id"] + [v[1] for v in VARIABLES_TO_EXTRACT] + ["puo_costruire", "sfondi"]
        with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as output_file:
            dict_writer = csv.DictWriter(output_file, fieldnames=headers)
            dict_writer.writeheader()
            dict_writer.writerows(all_units)
        print(f"\nCSV GENERATO: {len(all_units)} unità.")

if __name__ == "__main__":
    main()