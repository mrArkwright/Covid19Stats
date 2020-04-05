module About exposing (..)

import Html exposing (Html, main_, div, text, h1, h3, h4, p, br, ul, li)
import Html.Attributes exposing (class)


view : Html msg
view = main_ [class "container"] [
    div [class "row mt-4 mb-2"] [
      div [class "col"] [
        h1 [] [text "About"],
        h4 [] [text "Angaben gemäß § 5 TMG:"],
        p [] [
          text "Jannik Theiß",
          br [] [],
          text "Hasselbrookstr. 56",
          br [] [],
          text "22089 Hamburg"
        ],
        p [] [
          text "jnkthss [dot] dev [at] icloud [dot] com"
        ],
        h3 [] [text "Haftungsausschluss (Disclaimer)"],
        h4 [] [text "Haftung für Inhalte"],
        p [] [
          text "Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen."
        ],
        p [] [
          text "Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen."
        ],
        h4 [] [text "Haftung für Links"],
        p [] [
          text "Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar."
        ],
        p [] [
          text "Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen."
        ],
        h4 [] [text "Urheberrecht"],
        p [] [
          text "Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet."
        ],
        p [] [
          text "Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen."
        ],
        h3 [] [text "Datenschutz"],
        p [] [
          text "Die Betreiber dieser Seiten nehmen den Schutz Ihrer persönlichen Daten sehr ernst. Wir behandeln Ihre personenbezogenen Daten vertraulich und entsprechend der gesetzlichen Datenschutzvorschriften sowie dieser Datenschutzerklärung."
        ],
        p [] [
          text "Die Nutzung unserer Webseite ist in der Regel ohne Angabe personenbezogener Daten möglich. Soweit auf unseren Seiten personenbezogene Daten (beispielsweise Name, Anschrift oder E-Mail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche Zustimmung nicht an Dritte weitergegeben."
        ],
        p [] [
          text "Wir weisen darauf hin, dass die Datenübertragung im Internet (z.B. bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann. Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist nicht möglich."
        ],
        h4 [] [text "Server-Log-Files"],
        p [] [
          text "Der Provider der Seiten erhebt und speichert automatisch Informationen in so genannten Server-Log Files, die Ihr Browser automatisch an uns übermittelt. Dies sind:"
        ],
        ul [] [
          li [] [text "Browsertyp/ Browserversion"],
          li [] [text "verwendetes Betriebssystem"],
          li [] [text "Referrer URL"],
          li [] [text "Hostname des zugreifenden Rechners"],
          li [] [text "Uhrzeit der Serveranfrage"]
        ],
        p [] [
          text "Diese Daten sind nicht bestimmten Personen zuordenbar. Eine Zusammenführung dieser Daten mit anderen Datenquellen wird nicht vorgenommen. Wir behalten uns vor, diese Daten nachträglich zu prüfen, wenn uns konkrete Anhaltspunkte für eine rechtswidrige Nutzung bekannt werden."
        ],
        h4 [] [text "Einbindung von Diensten und Inhalten Dritter"],
        p [] [
          text "Es kann vorkommen, dass innerhalb dieses Onlineangebotes Inhalte Dritter, wie zum Beispiel Videos von YouTube, Kartenmaterial von Google-Maps, RSS-Feeds oder Grafiken von anderen Webseiten eingebunden werden. Dies setzt immer voraus, dass die Anbieter dieser Inhalte (nachfolgend bezeichnet als \"Dritt-Anbieter\") die IP-Adresse der Nutzer wahr nehmen. Denn ohne die IP-Adresse, könnten sie die Inhalte nicht an den Browser des jeweiligen Nutzers senden. Die IP-Adresse ist damit für die Darstellung dieser Inhalte erforderlich. Wir bemühen uns nur solche Inhalte zu verwenden, deren jeweilige Anbieter die IP-Adresse lediglich zur Auslieferung der Inhalte verwenden. Jedoch  haben wir keinen Einfluss darauf, falls die Dritt-Anbieter die IP-Adresse z.B. für statistische Zwecke speichern. Soweit dies uns bekannt ist, klären wir die Nutzer darüber auf."
        ],
        h4 [] [text "Auskunft, Löschung, Sperrung"],
        p [] [
          text "Sie haben jederzeit das Recht auf unentgeltliche Auskunft über Ihre gespeicherten personenbezogenen Daten, deren Herkunft und Empfänger und den Zweck der Datenverarbeitung sowie ein Recht auf Berichtigung, Sperrung oder Löschung dieser Daten. Hierzu sowie zu weiteren Fragen zum Thema personenbezogene Daten können Sie sich jederzeit an die oben genannte E-Mail Adresse wenden."
        ]
      ]
    ]
  ]