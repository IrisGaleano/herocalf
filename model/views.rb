# DB Loader
def views
  load_yaml('views') # /data/views.yml
end

# Behaviour if defined, or from DB-views by default.
def view(ruta)
  # Routes List
  
  # Spell routes
  es_element  = %w(aire agua fuego tierra).include?(ruta)
  es_sagrada  = %w(arena hielo sombra sangre).include?(ruta)
  es_plegaria = %w(plegarias execraciones).include?(ruta)
  #Heroes routes
  campeones   = %w(reservistas ausentes licenciados).include?(ruta)

  # Route preview loader
  nav = case
    # TODO: POST methods should be used the same
    when es_element  then 'hechizos'
    when es_sagrada  then 'sagradas'
    when es_plegaria then 'plegarias'
    when campeones   then 'heroes'
    else ruta # Usual rooting
  end

  # Return the matching route ('nav') from DB
  views.find { |v| v['ruta'] == nav }
end

# View meta info for component and layouts
def viewinfo(ruta)
  {
     title:  view(ruta)['ruta'], 
     bc:     breadcrumb(ruta),
     layout: view(ruta)['template']
  }
end

# Refined DATA hash-like
def preview(ruta)
  erb :template, locals: viewinfo(ruta)
end

# Only will be displayed if true (returns array)
def breadcrumb(ruta)
  bc = []
  if view(ruta)
    if view(ruta)['template']['main'].split('/').count > 1
      bc = view(ruta)['template']['main'].split('/')
    end
  end
  bc # empty arrays should be treated in ERB
end
