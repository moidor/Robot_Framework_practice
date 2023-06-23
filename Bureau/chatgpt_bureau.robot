*** Settings ***
Library  RPA.OpenAI
Library    Collections

*** Variables ***
${api_key}   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

*** Tasks ***
Create completion
    Authorize To OpenAI   ${api_key}
    ${completion}    Completion Create
    ...     Write strawberry ice cream description for an ice cream shop.
    ...     temperature=0.6
    Log   ${completion}

Create chat completion without conversation history
    Authorize To OpenAI   ${api_key}
    ${response}   @{chatgpt_conversation}=     Chat Completion Create
    ...    user_content=Que signifie tortue ?
    Log    ${response}
    Log    @{chatgpt_conversation}

Continue the conversation by using the conversation argument
    Authorize To OpenAI   ${api_key}
    ${response}   @{history}=     Chat Completion Create
    ...    user_content=Que signifie tortue ?
    Log    ${response}
    Log    @{history}
    ${carapace}     Should Contain    ${response}    carapace
    IF  ${carapace}
        Log    Carapace!!!!!!!!!!!
    END

    # la variable history2 est vide et reprend donc l'historique de la question précédente
    # dans le paramètre "conversation" puis ajoute l'historique de la deuxième question
    ${response}   @{history2}=     Chat Completion Create
    ...    conversation=${history}
    ...    user_content=Quelle est se durée de vie moyenne ?
    Log    ${response}
    Log    @{history2}
    ${carapace}     Should Contain   ${history2}    reptile
    IF  ${carapace}
        Log    String présent !
    ELSE
        Log    String absent...
    END

Afficher la valeur de la clé "content" du deuxième objet
    ${liste_objets}    Create List    {'role': 'user', 'content': 'Que signifie tortue ?'}
    # Le deuxième objet est ci-dessous et on le récupère avec [1]
    ...    {'role': 'assistant', 'content': 'Une tortue est un animal tétrapode reptilien caractérisé par sa carapace qui protège son corps.'}
    ...    {'role': 'user', 'content': 'Quelle est se durée de vie moyenne ?'}
    ...    {'role': 'assistant', 'content': "La durée de vie moyenne des tortues dépend de leur espèce et de leur environnement. Certaines tortues terrestres peuvent vivre jusqu'à 100 ans, tandis que d'autres, comme les tortues marines, ont une durée de vie plus courte. En général, la durée de vie moyenne des tortues varie de 30 à 80 ans."}

    ${objet}    Set Variable    ${liste_objets}[1]
    ${content}    Evaluate    ${objet}\['content'\]
    Log    ${content}
    
    ${contains}    Run Keyword And Return Status    Should Contain    ${content}    tétrapode reptilien
    Run Keyword If    ${contains}    Nouvelle question    Renvoie-moi une liste d'animaux tétrapodes reptiliens    


*** Keywords ***
Nouvelle question
    [Arguments]    ${question}
    Authorize To OpenAI   ${api_key}
    ${response}   @{chatgpt_conversation}=     Chat Completion Create
    ...    user_content=${question}
    Log    ${response}
    RETURN    ${response}