import pandas as pd
import argparse


def grade(SVLEN:int):
        try:
                SVLEN = int(SVLEN)
        except ValueError:
                return "Desconhecido"
        if SVLEN < 1000:
                return "Benigna"
        elif 1000 <= SVLEN <= 10000:
                return "Canonica"
        else:
                return "Complexa"

def process_table(tsv_file):
        df = pd.read_csv(tsv_file,sep="\t",header=None)
        df.columns = ["ID","Cromossomo","Start","End","Tipo","SVLEN"]
        df["Grau"] = df["SVLEN"].apply(lambda x:grade(x))
        return df.to_csv('variantes.csv', sep=',', index=False)

if __name__ == "__main__":
        parser = argparse.ArgumentParser(description="Converte TSV para CSV e adiciona classificação baseada no tamanho da variante.")
        parser.add_argument("tsv_file", help="Caminho do arquivo de entrada (.tsv)")
        args = parser.parse_args()
        process_table(args.tsv_file)
