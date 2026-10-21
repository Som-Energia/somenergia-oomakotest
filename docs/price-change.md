# Canvi de preus: plantilla reutilitzable

`input/correu-canviPreus-reutilitzable.mako` inclou els components compartits de
`som_polissa_condicions_generals/report/mailcanvipreus/`. No es modifica cap
plantilla històrica. Els textos editorials reals venen dels banners de la
campanya; les dates i l'assumpte venen del backend del lot.

La guia operativa i la matriu completa són a l'addon:

- `docs/guides/price-change-campaign.md`
- `docs/guides/price-change-verification.md`

## Proves locals sense ERP ni correus

Cal disposar de Mako, lxml i PyYAML. La ruta d'addons pot ser el worktree de Som
Energia directament: no cal canviar cap symlink compartit ni modificar GISCE ERP.

```bash
export OPENERP_TEMPLATE_ADDONS_PATH=/ruta/al/worktree/openerp_som_addons
PYENV_VERSION=erp python -m unittest -v test_price_change_render
python3 -m unittest -v test_price_change_render
```

Els deu casos de `canviPreusReutilitzable` a `testcases.yaml` són sintètics.
Comproven les dues llengües, tarifes, orígens d'estimació, impostos, autoconsum,
modificació pendent i Generation kWh. Les assertions numèriques i legals estan
versionades; no requereixen `configdb.py`, una DB, SMTP ni IDs de clients.

També es pot usar el B2B habitual:

```bash
mkdir -p b2bdata
PYENV_VERSION=erp ./oomako test canviPreusReutilitzable
```

En un checkout nou faltaran els esperats locals, perquè `b2bdata/` està ignorat
per Git. Reviseu els resultats i les assertions abans d'establir el primer
baseline amb `./oomako accept canviPreusReutilitzable`. No accepteu cegament
canvis posteriors. La selecció limita tant el test com l'acceptació al cas indicat.

Aquesta entrada no té `poweremailId`: **no s'utilitza per pujar contingut a
producció**. La plantilla Poweremail real es crea amb la configuració i migració
de l'addon. La renderització ERP continua utilitzant `configdb.py` i el mateix
`TemplateLookup` d'addons que Poweremail, amb una ruta optativa de worktree al
davant mitjançant `OPENERP_TEMPLATE_ADDONS_PATH`.
