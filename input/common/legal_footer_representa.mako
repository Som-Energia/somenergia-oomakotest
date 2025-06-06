<%
ovu_obj = object.pool.get('somre.ov.users')
env = ovu_obj.get_execution_environment_values(object._cr, object._uid)
name = env['name']
cif = env['vat']
%>
<font size="1" style="color:grey">
  <p>
      <i>[CA] <u>Informació bàsica sobre protecció de dades.</u> Responsable: <b>${name}</b> (CIF ${cif}). T'informem que les teves dades identificatives i les contingudes en els correus electrònics i fitxers adjunts poden ser incorporades a les nostres bases de dades amb la finalitat de mantenir relacions professionals i/o comercials i, que seran conservades mentre es mantingui la relació. Si ho desitges, pots exercir el teu dret a accedir, rectificar i suprimir les teves dades i d’altres reconeguts normativament dirigint-te al correu emissor o a <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Aquest missatge i qualsevol document que porti adjunt, si s’escau, pot ser confidencial i destinat únicament a la persona, entitat o empresa a qui ha estat enviat.</i>
  </p>
  <p>
      <i>[ES] <u>Información básica sobre protección de datos.</u> Responsable: <b>${name}</b> (CIF ${cif}). Te informamos que tus datos identificativos y los contenidos en los correos electrónicos y ficheros adjuntos pueden ser incorporados a nuestras bases de datos con la finalidad de mantener relaciones profesionales y/o comerciales y, que serán conservados mientras se mantenga la relación. Si lo deseas, puedes ejercer tu derecho a acceder, rectificar y suprimir sus datos y demás reconocidos normativamente dirigiéndose al correo emisor o en <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Este mensaje y cualquier documento que lleve adjunto, en su caso, puede ser confidencial y destinado únicamente a la persona, entidad o empresa a quien ha sido enviado.</i>
  </p>
</font>
