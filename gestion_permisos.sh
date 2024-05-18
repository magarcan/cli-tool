#!/bin/bash

while true; do
    clear
    echo "Gestión de Grupos en Linux"
    echo "Selecciona una opción:"
    echo "1. Ver grupos existentes"
    echo "2. Crear un nuevo grupo"
    echo "3. Añadir usuario a un grupo"
    echo "4. Cambiar el grupo propietario de una carpeta"
    echo "5. Modificar permisos de una carpeta"
    echo "6. Salir"
    echo "7. Ver usuarios de un grupo"
    echo "8. Ver permisos de un grupo sobre una carpeta"
    read -p "Introduce tu opción: " opcion

    case $opcion in
        1) 
            echo "Grupos existentes:"
            cut -d: -f1 /etc/group
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        2) 
            read -p "Nombre del nuevo grupo: " grupo
            sudo groupadd $grupo
            echo "Grupo '$grupo' creado."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        3) 
            read -p "Nombre del usuario: " usuario
            read -p "Nombre del grupo: " grupo
            sudo usermod -aG $grupo $usuario
            echo "Usuario '$usuario' añadido al grupo '$grupo'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        4)
            read -p "Ruta de la carpeta: " carpeta
            read -p "Nombre del grupo propietario: " grupo
            sudo chown :$grupo $carpeta
            echo "Grupo propietario de '$carpeta' cambiado a '$grupo'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        5)
            read -p "Ruta de la carpeta: " carpeta
            read -p "Permisos (ejemplo 755): " permisos
            sudo chmod $permisos $carpeta
            echo "Permisos de '$carpeta' cambiados a '$permisos'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        6) 
            echo "Saliendo..."
            exit 0
            ;;
        7)
            read -p "Nombre del grupo para ver sus usuarios: " grupo
            echo "Usuarios del grupo '$grupo':"
            grep $grupo /etc/group | cut -d: -f4
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        8)
            read -p "Ruta de la carpeta para verificar: " carpeta
            read -p "Nombre del grupo para verificar permisos: " grupo
            echo "Permisos para el grupo '$grupo' en la carpeta '$carpeta':"
            ls -ld $carpeta | awk '{print $1 " " $4}'
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        *)
            echo "Opción no válida."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
    esac
done
