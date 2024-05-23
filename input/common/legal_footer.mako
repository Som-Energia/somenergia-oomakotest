<%
    lang = False
    # Hack to render only the legal footer paragraf of the language of the template object
    if object.__hasattr__('titular') and object.titular and object.titular.lang:
        lang = object.titular.lang
    elif object.__hasattr__('polissa_id') and object.polissa_id and object.polissa_id.__hasattr__('titular') and object.polissa_id.titular and object.polissa_id.titular.lang:
        lang = object.polissa_id.titular.lang
    elif object.__hasattr__('cups_polissa_id') and object.cups_polissa_id and object.cups_polissa_id.__hasattr__('titular') and object.cups_polissa_id.titular and object.cups_polissa_id.titular.lang:
        lang = object.cups_polissa_id.titular.lang
    elif object.__hasattr__('member_id') and object.member_id and object.member_id.__hasattr__('partner_id') and object.member_id.partner_id and object.member_id.partner_id.lang:
        lang = object.member_id.partner_id.lang
    elif object.__hasattr__('partner_id') and object.partner_id and object.partner_id.lang:
        lang = object.partner_id.lang
    elif object.lang:
        lang = object.lang
    else:
        lang = 'other'
%>

<font size="1" style="color:grey">
% if lang != "es_ES":
  <p>
      <i>[CA] <u>Informació bàsica sobre protecció de dades.</u> Responsable: <b>SOM ENERGIA, SCCL.</b> (CIF F55091367). T'informem que les teves dades identificatives i les contingudes en els correus electrònics i fitxers adjunts poden ser incorporades a les nostres bases de dades amb la finalitat de mantenir relacions professionals i/o comercials i, que seran conservades mentre es mantingui la relació. Si ho desitges, pots exercir el teu dret a accedir, rectificar, cancel·lar, efectuar una portabilitat de dades, limitar i suprimir les teves dades i d'altres reconeguts normativament dirigint-te al correu emissor o a <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Aquest missatge i qualsevol document que porti adjunt, si s’escau, pot ser confidencial i destinat únicament a la persona, entitat o empresa a qui ha estat enviat.</i>
  </p>
% endif
% if lang != "ca_ES":
  <p>
      <i>[ES] <u>Información básica sobre protección de datos.</u> Responsable: <b>SOM ENERGIA, SCCL.</b> (CIF F55091367). Te informamos que tus datos identificativos y los contenidos en los correos electrónicos y ficheros adjuntos pueden ser incorporados a nuestras bases de datos con la finalidad de mantener relaciones profesionales y/o comerciales y, que serán conservados mientras se mantenga la relación. Si lo deseas, puedes ejercer tu derecho a acceder, rectificar, cancelar, efectuar una portabilidad de datos, limitar y suprimir tus datos y otros reconocidos normativamente dirigiéndote al correo emisor o en <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Este mensaje y cualquier documento que lleve adjunto, en su caso, puede ser confidencial y destinado únicamente a la persona, entidad o empresa a quien ha sido enviado.</i>
  </p>
% endif
</font>
