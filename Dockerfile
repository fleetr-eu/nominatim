FROM cartography/nominatim-docker

RUN curl http://download.geofabrik.de/europe/bulgaria-latest.osm.pbf --create-dirs -o /app/src/data.osm.pbf

RUN service postgresql start && \
    sudo -u nominatim ./utils/setup.php --import-data --osm-file /app/src/data.osm.pbf && \
    service postgresql stop && \
    rm /app/src/data.osm.pbf
