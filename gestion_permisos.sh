#!/bin/bash

echo "Gestión de Grupos en Linux"
echo "Selecciona una opción:"
echo "1. Ver grupos existentes"
echo "2. Crear un nuevo grupo"
echo "3. Añadir usuario a un grupo"
echo "4. Cambiar el grupo propietario de una carpeta"
echo "5. Modificar permisos de una carpeta"
read -p "Introduce tu opción: " opcion

case $opcion in
    1) 
        echo "Grupos existentes:"
        cut -d: -f1 /etc/group
        ;;
    2) 
        read -p "Nombre del nuevo grupo: " grupo
        sudo groupadd $grupo
        echo "Grupo '$grupo' creado."
        ;;
    3) 
        read -p "Nombre del usuario: " usuario
        read -p "Nombre del grupo: " grupo
        sudo usermod -aG $grupo $usuario
        echo "Usuario '$usuario' añadido al grupo '$grupo'."
        ;;
    4)
        read -p "Ruta de la carpeta: " carpeta
        read -p "Nombre del grupo propietario: " grupo
        sudo chown :$grupo $carpeta
        echo "Grupo propietario de '$carpeta' cambiado a '$grupo'."
        ;;
    5)
        read -p "Ruta de la carpeta: " carpeta
        read -p "Permisos (ejemplo 755): " permisos
        sudo chmod $permisos $carpeta
        echo "Permisos de '$carpeta' cambiados a '$permisos'."
        ;;
    *)
        echo "Opción no válida."
        ;;
esac
