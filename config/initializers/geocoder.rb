
Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  # lookup: :google,            # name of geocoding service (symbol)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
  # street address geocoding service (default :google)
 :lookup => :google,

  # IP address geocoding service (see below for supported options):
  # :ip_lookup => :maxmind,

  # to use an API key:
  :api_key => "AIzaSyCNDonXfyB1y-3fm5yQrmaUxdq-5ydBbUI",

  # # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # # set default units to kilometers:
  # :units => :km,

  # # caching (see below for details):
  :cache => $redis,
  :cache_prefix => "m4m"


)
