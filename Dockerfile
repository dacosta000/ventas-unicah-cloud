FROM odoo:20.0

USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN mkdir -p /opt/odoo-data && chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf /opt/odoo-data

USER odoo
RUN odoo -c /etc/odoo/odoo.conf -d odoo-db-unicah -u web,ventas_unicah --stop-after-init \
    && (odoo -c /etc/odoo/odoo.conf & \
        PID=$!; \
        sleep 12; \
        curl -s http://127.0.0.1:8069/web/login > /dev/null; \
        sleep 5; \
        kill $PID; \
        wait $PID || true)

EXPOSE 8069
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]