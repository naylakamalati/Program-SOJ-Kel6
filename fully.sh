#!/bin/bash

# Menampilkan pilihan kepada pengguna
echo "Pilih salah satu opsi berikut:"
echo "╔═════════════════════════════════╗"
echo "║     Pilih login sebagai apa     ║"
echo "╟═════════════════════════════════╢"
echo "║ 1. Murid                        ║"
echo "║ 2. Guru                         ║"
echo "║ 3. Exit                         ║"
echo "╚═════════════════════════════════╝"

# Membaca input dari pengguna
read -p "Masukkan pilihan Anda (1/2/3): " pilihan

# Memproses pilihan dan menampilkan pesan sesuai pilihan
case $pilihan in
    1)
        # Nama pengguna dan kata sandi yang sudah ditentukan
        NAMA_PENGGUNA="Murid"
        KATA_SANDI="qwerty"

        # Fungsi untuk melakukan login
        login() {
            read -p "Nama Pengguna: " input_nama_pengguna
            read -sp "Kata Sandi: " input_kata_sandi
            echo

            if [[ "$input_nama_pengguna" == "$NAMA_PENGGUNA" && "$input_kata_sandi" == "$KATA_SANDI" ]]; then
                echo "Login berhasil!"
                return 0
            else
                echo "Nama pengguna atau kata sandi salah."
                return 1
            fi
        }

        # Eksekusi utama script
        # Fungsi untuk memilih mata pelajaran dan menjawab soal
        jawab_soal() {
            lagi="y"
            while [ "$lagi" = "y" ]; do
                clear
                echo "╔═════════════════════════════╗"
                echo "║   Pilih mata pelajaran:     ║"
                echo "╟═════════════════════════════╢"
                echo "║   1. MTK                    ║"
                echo "║   2. IPA                    ║"
                echo "║   3. IPS                    ║"
                echo "║   4. Bahasa Indonesia       ║"
                echo "║   5. Bahasa Inggris         ║"
                echo "║                             ║"
                echo "╚═════════════════════════════╝"
                read -p "Pilihan: " pilihan

                case $pilihan in
                    1)
                        for soal in "${!soal_mtk[@]}"; do
                            echo "$soal"
                            read -p "Jawaban Anda: " jawaban
                            if [ "$jawaban" == "${soal_mtk[$soal]}" ]; then
                                echo "Jawaban benar!"
                            else
                                echo "Jawaban salah. Jawaban yang benar adalah ${soal_mtk[$soal]}"
                            fi
                        done
                        ;;
                    2)
                        for soal in "${!soal_ipa[@]}"; do
                            echo "$soal"
                            read -p "Jawaban Anda: " jawaban
                            if [ "$jawaban" == "${soal_ipa[$soal]}" ]; then
                                echo "Jawaban benar!"
                            else
                                echo "Jawaban salah. Jawaban yang benar adalah ${soal_ipa[$soal]}"
                            fi
                        done
                        ;;
                    3)
                        for soal in "${!soal_ips[@]}"; do
                            echo "$soal"
                            read -p "Jawaban Anda: " jawaban
                            if [ "$jawaban" == "${soal_ips[$soal]}" ]; then
                                echo "Jawaban benar!"
                            else
                                echo "Jawaban salah. Jawaban yang benar adalah ${soal_ips[$soal]}"
                            fi
                        done
                        ;;
                    4)
                        for soal in "${!soal_bahasa_indonesia[@]}"; do
                            echo "$soal"
                            read -p "Jawaban Anda: " jawaban
                            if [ "$jawaban" == "${soal_bahasa_indonesia[$soal]}" ]; then
                                echo "Jawaban benar!"
                            else
                                echo "Jawaban salah. Jawaban yang benar adalah ${soal_bahasa_indonesia[$soal]}"
                            fi
                        done
                        ;;
                    5)
                        for soal in "${!soal_bahasa_inggris[@]}"; do
                            echo "$soal"
                            read -p "Jawaban Anda: " jawaban
                            if [ "$jawaban" == "${soal_bahasa_inggris[$soal]}" ]; then
                                echo "Jawaban benar!"
                            else
                                echo "Jawaban salah. Jawaban yang benar adalah ${soal_bahasa_inggris[$soal]}"
                            fi
                        done
                        ;;
                    n|N)
                        echo "Keluar dari program."
                        exit 0
                        ;;
                    *) echo "Pilihan tidak valid!" ;;
                esac
                read -p "Apakah Anda ingin memilih mata pelajaran lain? (y/n): " lagi
            done
            exit 0
        }

        # Muat soal dari file JSON ke dalam array
        declare -A soal_mtk
        declare -A soal_ipa
        declare -A soal_ips
        declare -A soal_bahasa_indonesia
        declare -A soal_bahasa_inggris

        muat_array() {
            local file=$1
            declare -n arr=$2
            while IFS="=" read -r soal jawaban; do
                arr["$soal"]="$jawaban"
            done < <(jq -r 'to_entries | .[] | "\(.key)=\(.value)"' "$file")
        }

        # Tentukan lokasi file JSON Anda
        FILE_MTK="soal_mtk.json"
        FILE_IPA="soal_ipa.json"
        FILE_IPS="soal_ips.json"
        FILE_BAHASA_INDONESIA="soal_bahasa_indonesia.json"
        FILE_BAHASA_INGGRIS="soal_bahasa_inggris.json"

        # Muat soal dari file JSON ke dalam array
        muat_array "$FILE_MTK" soal_mtk
        muat_array "$FILE_IPA" soal_ipa
        muat_array "$FILE_IPS" soal_ips
        muat_array "$FILE_BAHASA_INDONESIA" soal_bahasa_indonesia
        muat_array "$FILE_BAHASA_INGGRIS" soal_bahasa_inggris

        # Mencoba login hingga 3 kali
        for i in {1..3}; do
            if login; then
                jawab_soal
            else
                echo "Percobaan $i dari 3 gagal."
            fi
        done

        echo "Terlalu banyak percobaan gagal. Keluar."
        exit 1
        ;;
    2)
        # Nama pengguna dan kata sandi yang sudah ditentukan
        NAMA_PENGGUNA="Guru"
        KATA_SANDI="qwerty"

        # Fungsi untuk melakukan login
        login() {
            read -p "Nama Pengguna: " input_nama_pengguna
            read -sp "Kata Sandi: " input_kata_sandi
            echo

            if [[ "$input_nama_pengguna" == "$NAMA_PENGGUNA" && "$input_kata_sandi" == "$KATA_SANDI" ]]; then
                echo "Login berhasil!"
                return 0
            else
                echo "Nama pengguna atau kata sandi salah."
                return 1
            fi
        }

        # Fungsi untuk menyimpan soal ke file JSON
        simpan_array_ke_file() {
            local file=$1
            declare -n arr=$2

            # Debug: Output the file path for verification
            echo "Saving data to file: $file"

            # Check if $file is not empty
            if [ -z "$file" ]; then
                echo "Error: File path is empty."
                return 1
            fi

            # Use jq to write array to JSON file
            jq -n --argjson data "$(declare -p arr | sed 's/declare -A \w\+ (\([^)]\+\))/\1/' | jq -R 'split(" ") | map(split("=")) | map({(.[0]): .[1]}) | add')" '$data' > "$file"
        }

        # Fungsi CRUD untuk mengelola soal
        crud_soal() {
            lagi="y"
            while [ "$lagi" = "y" ]; do
                clear
                echo "╔═════════════════════════════╗"
                echo "║      Menu Manajemen Soal    ║"
                echo "╟═════════════════════════════╢"
                echo "║ 1. Tambah Soal              ║"
                echo "║ 2. Tampilkan Soal           ║"
                echo "║ 3. Update Soal              ║"
                echo "║ 4. Hapus Soal               ║"
                echo "║ 5. Keluar                   ║"
                echo "╚═════════════════════════════╝"
                read -p "Pilihan: " pilihan

                case $pilihan in
                    1)  # Tambah Soal
                        echo "Pilih mata pelajaran:"
                        echo "1. MTK"
                        echo "2. IPA"
                        echo "3. IPS"
                        echo
                        echo "4. Bahasa Indonesia"
                        echo "5. Bahasa Inggris"
                        read -p "Pilihan: " mapel

                        read -p "Masukkan soal: " soal
                        read -p "Masukkan jawaban: " jawaban

                        case $mapel in
                            1)
                                soal_mtk["$soal"]="$jawaban"
                                simpan_array_ke_file "$FILE_MTK" soal_mtk
                                ;;
                            2)
                                soal_ipa["$soal"]="$jawaban"
                                simpan_array_ke_file "$FILE_IPA" soal_ipa
                                ;;
                            3)
                                soal_ips["$soal"]="$jawaban"
                                simpan_array_ke_file "$FILE_IPS" soal_ips
                                ;;
                            4)
                                soal_bahasa_indonesia["$soal"]="$jawaban"
                                simpan_array_ke_file "$FILE_BAHASA_INDONESIA" soal_bahasa_indonesia
                                ;;
                            5)
                                soal_bahasa_inggris["$soal"]="$jawaban"
                                simpan_array_ke_file "$FILE_BAHASA_INGGRIS" soal_bahasa_inggris
                                ;;
                            *)
                                echo "Pilihan tidak valid!"
                                ;;
                        esac
                        ;;
                    2)  # Tampilkan Soal
                        echo "Pilih mata pelajaran:"
                        echo "1. MTK"
                        echo "2. IPA"
                        echo "3. IPS"
                        echo "4. Bahasa Indonesia"
                        echo "5. Bahasa Inggris"
                        read -p "Pilihan: " mapel

                        case $mapel in
                            1)
                                for soal in "${!soal_mtk[@]}"; do
                                    echo "Soal: $soal - Jawaban: ${soal_mtk[$soal]}"
                                done
                                ;;
                            2)
                                for soal in "${!soal_ipa[@]}"; do
                                    echo "Soal: $soal - Jawaban: ${soal_ipa[$soal]}"
                                done
                                ;;
                            3)
                                for soal in "${!soal_ips[@]}"; do
                                    echo "Soal: $soal - Jawaban: ${soal_ips[$soal]}"
                                done
                                ;;
                            4)
                                for soal in "${!soal_bahasa_indonesia[@]}"; do
                                    echo "Soal: $soal - Jawaban: ${soal_bahasa_indonesia[$soal]}"
                                done
                                ;;
                            5)
                                for soal in "${!soal_bahasa_inggris[@]}"; do
                                    echo "Soal: $soal - Jawaban: ${soal_bahasa_inggris[$soal]}"
                                done
                                ;;
                            *)
                                echo "Pilihan tidak valid!"
                                ;;
                        esac
                        ;;
                    3)  # Update Soal
                        echo "Pilih mata pelajaran:"
                        echo "1. MTK"
                        echo "2. IPA"
                        echo "3. IPS"
                        echo "4. Bahasa Indonesia"
                        echo "5. Bahasa Inggris"
                        read -p "Pilihan: " mapel

                        read -p "Masukkan soal yang akan diupdate: " soal
                        read -p "Masukkan jawaban baru: " jawaban

                        case $mapel in
                            1)
                                if [[ -v soal_mtk["$soal"] ]]; then
                                    soal_mtk["$soal"]="$jawaban"
                                    simpan_array_ke_file "$FILE_MTK" soal_mtk
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            2)
                                if [[ -v soal_ipa["$soal"] ]]; then
                                    soal_ipa["$soal"]="$jawaban"
                                    simpan_array_ke_file "$FILE_IPA" soal_ipa
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            3)
                                if [[ -v soal_ips["$soal"] ]]; then
                                    soal_ips["$soal"]="$jawaban"
                                    simpan_array_ke_file "$FILE_IPS" soal_ips
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            4)
                                if [[ -v soal_bahasa_indonesia["$soal"] ]]; then
                                    soal_bahasa_indonesia["$soal"]="$jawaban"
                                    simpan_array_ke_file "$FILE_BAHASA_INDONESIA" soal_bahasa_indonesia
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            5)
                                if [[ -v soal_bahasa_inggris["$soal"] ]]; then
                                    soal_bahasa_inggris["$soal"]="$jawaban"
                                    simpan_array_ke_file "$FILE_BAHASA_INGGRIS" soal_bahasa_inggris
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            *)
                                echo "Pilihan tidak valid!"
                                ;;
                        esac
                        ;;
                    4)  # Hapus Soal
                        echo "Pilih mata pelajaran:"
                        echo "1. MTK"
                        echo "2. IPA"
                        echo "3. IPS"
                        echo "4. Bahasa Indonesia"
                        echo "5. Bahasa Inggris"
                        read -p "Pilihan: " mapel

                        read -p "Masukkan soal yang akan dihapus: " soal

                        case $mapel in
                            1)
                                if [[ -v soal_mtk["$soal"] ]]; then
                                    unset soal_mtk["$soal"]
                                    simpan_array_ke_file "$FILE_MTK" soal_mtk
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            2)
                                if [[ -v soal_ipa["$soal"] ]]; then
                                    unset soal_ipa["$soal"]
                                    simpan_array_ke_file "$FILE_IPA" soal_ipa
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            3)
                                if [[ -v soal_ips["$soal"] ]]; then
                                    unset soal_ips["$soal"]
                                    simpan_array_ke_file "$FILE_IPS" soal_ips
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            4)
                                if [[ -v soal_bahasa_indonesia["$soal"] ]]; then
                                    unset soal_bahasa_indonesia["$soal"]
                                    simpan_array_ke_file "$FILE_BAHASA_INDONESIA" soal_bahasa_indonesia
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            5)
                                if [[ -v soal_bahasa_inggris["$soal"] ]]; then
                                    unset soal_bahasa_inggris["$soal"]
                                    simpan_array_ke_file "$FILE_BAHASA_INGGRIS" soal_bahasa_inggris
                                else
                                    echo "Soal tidak ditemukan."
                                fi
                                ;;
                            *)
                                echo "Pilihan tidak valid!"
                                ;;
                        esac
                        ;;
                    5)  # Keluar
                        echo "Keluar dari program."
                        exit 0
                        ;;
                    *)
                        echo "Pilihan tidak valid!"
                        ;;
                esac
                read -p "Apakah Anda ingin mengelola soal lain? (y/n): " lagi
            done
            exit 0
        }

        # Muat soal dari file JSON ke dalam array
        declare -A soal_mtk
        declare -A soal_ipa
        declare -A soal_ips
        declare -A soal_bahasa_indonesia
        declare -A soal_bahasa_inggris

        muat_array() {
            local file=$1
            declare -n arr=$2
            while IFS="=" read -r soal jawaban; do
                arr["$soal"]="$jawaban"
            done < <(jq -r 'to_entries | .[] | "\(.key)=\(.value)"' "$file")
        }

        # Tentukan lokasi file JSON Anda
        FILE_MTK="soal_mtk.json"
        FILE_IPA="soal_ipa.json"
        FILE_IPS="soal_ips.json"
        FILE_BAHASA_INDONESIA="soal_bahasa_indonesia.json"
        FILE_BAHASA_INGGRIS="soal_bahasa_inggris.json"

        # Muat soal dari file JSON ke dalam array
        muat_array "$FILE_MTK" soal_mtk
        muat_array "$FILE_IPA" soal_ipa
        muat_array "$FILE_IPS" soal_ips
        muat_array "$FILE_BAHASA_INDONESIA" soal_bahasa_indonesia
        muat_array "$FILE_BAHASA_INGGRIS" soal_bahasa_inggris

        # Mencoba login hingga 3 kali
        for i in {1..3}; do
            if login; then
                crud_soal
            else
                echo "Percobaan $i dari 3 gagal."
            fi
        done

        echo "Terlalu banyak percobaan gagal. Keluar."
        exit 1
        ;;
    3)
        echo "Keluar dari program."
        exit 0
        ;;
    *)
        echo "Pilihan tidak valid!"
        ;;
esac
