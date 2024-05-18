#!/bin/bash

while true; do
    clear
    echo "Gestión de Grupos en Linux"
    echo "Selecciona una opción:"
    echo "1. Ver grupos existentes"
    echo "2. Ver usuarios de un grupo"
    echo "3. Crear un nuevo grupo"
    echo "4. Añadir usuario a un grupo"
    echo "5. Cambiar el grupo propietario de una carpeta"
    echo "6. Ver permisos de un grupo sobre una carpeta"
    echo "7. Modificar permisos de una carpeta para un grupo"
    echo "8. Salir"
    read -p "Introduce tu opción: " opcion

    case $opcion in
        1) 
            echo "Grupos existentes:"
            cut -d: -f1 /etc/group
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        2)
            read -p "Nombre del grupo para ver sus usuarios: " grupo
            echo "Usuarios del grupo '$grupo':"
            grep $grupo /etc/group | cut -d: -f4
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        3) 
            read -p "Nombre del nuevo grupo: " grupo
            sudo groupadd $grupo
            echo "Grupo '$grupo' creado."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        4) 
            read -p "Nombre del usuario: " usuario
            read -p "Nombre del grupo: " grupo
            sudo usermod -aG $grupo $usuario
            echo "Usuario '$usuario' añadido al grupo '$grupo'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        5)
            read -p "Ruta de la carpeta: " carpeta
            read -p "Nombre del grupo propietario: " grupo
            sudo chown :$grupo $carpeta
            echo "Grupo propietario de '$carpeta' cambiado a '$grupo'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        6)
            read -p "Ruta de la carpeta para verificar: " carpeta
            read -p "Nombre del grupo para verificar permisos: " grupo
            echo "Permisos para el grupo '$grupo' en la carpeta '$carpeta':"
            permisos=$(ls -ld $carpeta | awk '{print $1}')
            echo "Permisos actuales: $permisos"
            echo "Explicación:"
            echo "    - Primer carácter: indica el tipo ('d' para directorio, '-' para archivo)"
            echo "    - Siguientes tres caracteres: permisos del propietario ('r' leer, 'w' escribir, 'x' ejecutar)"
            echo "    - Siguientes tres caracteres: permisos del grupo"
            echo "    - Últimos tres caracteres: permisos para otros"
            echo "Ejemplo de permisos: 'drwxr-x---' significa que el propietario tiene todos los permisos, el grupo puede leer y ejecutar, y otros no tienen permisos."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        7)
            read -p "Ruta de la carpeta: " carpeta
            read -p "Nombre del grupo: " grupo
            echo "Introduce los permisos para el grupo usando la notación 'g=permisos'. Ejemplos:"
            echo "    g=rwx - Grupo puede leer, escribir y ejecutar"
            echo "    g=r-- - Grupo solo puede leer"
            echo "    g=--- - Grupo no tiene permisos"
            read -p "Permisos para el grupo: " permisos_grupo
            sudo chmod g="$permisos_grupo" $carpeta
            echo "Permisos para el grupo '$grupo' en la carpeta '$carpeta' modificados a '$permisos_grupo'."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
        8) 
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida."
            read -p "Presiona cualquier tecla para continuar..." readEnterKey
            ;;
    esac
done
