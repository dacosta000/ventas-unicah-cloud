FROM odoo:20.0

USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN mkdir -p /opt/odoo-data && chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf /opt/odoo-data

USER odoo
CMD ["sh", "-c", "/entrypoint.sh odoo -c /etc/odoo/odoo.conf -d odoo-db-unicah -i base,ventas_unicah --without-demo=True --stop-after-init && /entrypoint.sh odoo -c /etc/odoo/odoo.conf"]