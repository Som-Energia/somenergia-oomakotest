# AGENTS.md - Instruccions per a Agents IA

Aquest fitxer conté les instruccions i convencions que qualsevol agent IA ha de seguir quan treballi amb el repositori `somenergia-oomakotest`.

## Tech Stack

- **Plantilles**: Mako templates (correus electrònics)
- **Testing**: oomakote (test framework propi)
- **Format**: .mako + .yaml

## Estructura del Projecte

```
somenergia-oomakotest/
├── input/                    # Plantilles de correu .mako
├── testcases.yaml           # Test cases
└── expected/               # Outputs esperats
```

## Convencions de Git

### Branca

Format: `<TYPE>_<descripció>`

| Prefix | Ús |
|--------|-----|
| `ADD_` | Nova funcionalitat o template |
| `IMP_` | Millora d'un template existent |
| `FIX_` | Bug fix |
| `MOD_` | Canvi de comportament |
| `TEST_` | Tests o testcases |

Exemples:
- `ADD_r1_reminder_email_template`
- `FIX_typo_in_invoice_template`

### Commit

Format: `<emoji> <type>: <descripció>`

Emojis i tipus (gitmoji.dev):
- ✨ :sparkles: Nova funcionalitat
- 🎨 :art: Canvis d'estil (sense canvi de lògica)
- 🐛 :bug: Bug fix
- ♻️ :recycle: Refactorització
- ⚡️ :zap: Millora de performance
- ✅ :white_check_mark: Tests
- 📝 :memo: Documentació
- 🔧 :wrench: Canvis de configuració

Exemples:
- `✨ feat: add R1 reminder email template`
- `🐛 fix: correct typo in invoice subject`

## Workflow

1. Crear branca des de `master`
2. Fer els canvis
3. Commit amb convenció
4. Pujar branca i crear PR (si cal)

## Comprovacions abans de commit

- [ ] El template .mako és vàlid (sintaxi Mako)
- [ ] El .yaml té els camps requerits
- [ ] El testcase està registrat a testcases.yaml