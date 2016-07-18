FROM cartography/nominatim-docker

RUN curl http://download.geofabrik.de/europe/bulgaria-latest.osm.pbf --create-dirs -o /app/src/data.osm.pbf

RUN service postgresql start && \
   sudo -u postgres psql postgres -c "DROP DATABASE IF EXISTS nominatim" && \
   sudo -u nominatim ./utils/setup.php --osm-file /app/src/data.osm.pbf --all --threads 2 && \
   service postgresql stop
