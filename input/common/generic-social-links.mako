<%
  lang = context.get('lang') or 'ca_ES'

  telegram_url = 'https://t.me/somenergia_es'
  if lang == 'ca_ES':
    telegram_url = 'https://t.me/somenergia'
%>

<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td align="center" style="padding: 10px 0;">
      <a href="https://mastodon.economiasocial.org/@SomEnergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/mastodon.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/mastodon.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/mastodon.png" alt="Mastodon" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.instagram.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/instagram.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/instagram.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/instagram.png" alt="Instagram" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.facebook.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/facebook.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/facebook.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/facebook.png" alt="Facebook" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://x.com/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/x.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/x.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/x.png" alt="X" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="${telegram_url}" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/telegram.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/telegram.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/telegram.png" alt="Telegram" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.youtube.com/user/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/youtube.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/youtube.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/youtube.png" alt="Youtube" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
      <a href="https://www.linkedin.com/company/somenergia" target="_blank" style="margin:0 10px; display:inline-block;">
        <picture>
          <source srcset="https://www.somenergia.coop/wpsom/social/primary/linkedin.png" media="(prefers-color-scheme: light)"/>
          <source srcset="https://www.somenergia.coop/wpsom/social/linkedin.png" media="(prefers-color-scheme: dark)"/>
          <img src="https://www.somenergia.coop/wpsom/social/primary/linkedin.png" alt="Linkedin" width="32" height="32" border="0" style="display:block;"/>
        </picture>
      </a>
    </td>
  </tr>
</table>
