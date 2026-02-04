                      </div>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

<%
  ovu_obj = object.pool.get('somre.ov.users')
  env = ovu_obj.get_execution_environment_values(object._cr, object._uid)
  name = env['name']
  cif = env['vat']
  lang = object.lang
%>

    <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td align="center">
          <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
            <tr>
              <td class="email-masthead">
                <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
                  <tr>
                    <th>
                      <p>
                        <font size="1" style="color:grey">
                          % if lang != "es_ES":
                            <p>
                              <i>[CA] <u>Informació bàsica sobre protecció de dades.</u> Responsable: <b>${name}</b> (CIF ${cif}). T'informem que les teves dades identificatives i les contingudes en els correus electrònics i fitxers adjunts poden ser incorporades a les nostres bases de dades amb la finalitat de mantenir relacions professionals i/o comercials i, que seran conservades mentre es mantingui la relació. Si ho desitges, pots exercir el teu dret a accedir, rectificar i suprimir les teves dades i d’altres reconeguts normativament dirigint-te al correu emissor o a <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Aquest missatge i qualsevol document que porti adjunt, si s’escau, pot ser confidencial i destinat únicament a la persona, entitat o empresa a qui ha estat enviat.</i>
                            </p>
                          % endif
                          % if lang != "ca_ES":
                            <p>
                              <i>[ES] <u>Información básica sobre protección de datos.</u> Responsable: <b>${name}</b> (CIF ${cif}). Te informamos que tus datos identificativos y los contenidos en los correos electrónicos y ficheros adjuntos pueden ser incorporados a nuestras bases de datos con la finalidad de mantener relaciones profesionales y/o comerciales y, que serán conservados mientras se mantenga la relación. Si lo deseas, puedes ejercer tu derecho a acceder, rectificar y suprimir sus datos y demás reconocidos normativamente dirigiéndose al correo emisor o en <a href="mailto:somenergia@delegado-datos.com" target="_blank" style="color:#707a1a; text-decoration:underline;" rel="noopener noreferrer">somenergia@delegado-datos.com</a>. Este mensaje y cualquier documento que lleve adjunto, en su caso, puede ser confidencial y destinado únicamente a la persona, entidad o empresa a quien ha sido enviado.</i>
                            </p>
                          % endif
                        </font>
                      </p>
                    </th>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>