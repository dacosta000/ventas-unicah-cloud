FROM odoo:19.0

USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf

USER odoo
CMD ["odoo", "-c", "/etc/odoo/odoo.conf", "-d", "odoo-db-unicah", "-i", "base,ventas_unicah", "--without-demo=all"]