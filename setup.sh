# from https://discuss.streamlit.io/t/not-able-to-deploy-to-heroku-error-in-creating-config-toml/4503
mkdir -p ~/.streamlit

echo "[server]
headless = true
port = $PORT
enableCORS = false
" > ~/.streamlit/config.toml