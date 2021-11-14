#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

vAction=$1

function generate_ffmpeg_wrapper() {
    echo "生成 ffmpeg 脚本"
    echo "IyEvYmluL2Jhc2gKCnJldj0iMTIiCgpfbG9nKCl7CgllY2hvICIkKGRhdGUgJyslWS0lbS0lZCAlSDolTTolUycpIC0gJHtzdHJlYW1pZH0gLSAkMSIgPj4gL3RtcC9mZm1wZWcubG9nCn0KCl9sb2dfcGFyYSgpewoJZWNobyAiJDEiIHwgZm9sZCAtdyAxMjAgfCBzZWQgInMvXi4qJC8kKGRhdGUgJyslWS0lbS0lZCAlSDolTTolUycpIC0gJHtzdHJlYW1pZH0gLSAgICAgICAgICA9ICYvIiA+PiAvdG1wL2ZmbXBlZy5sb2cKfQoKX3Rlcm0oKXsKCXJtIC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVycgoJX2xvZyAiKioqIEtJTExDSElMRCAqKioiCglraWxsIC1URVJNICIkY2hpbGRwaWQiIDI+L2Rldi9udWxsCn0KCnRyYXAgX3Rlcm0gU0lHVEVSTQoKYXJjaD1gdW5hbWUgLWEgfCBzZWQgJ3MvLipzeW5vbG9neV8vLycgfCBjdXQgLWQgJ18nIC1mIDFgCm5hcz1gdW5hbWUgLWEgfCBzZWQgJ3MvLipzeW5vbG9neV8vLycgfCBjdXQgLWQgJ18nIC1mIDJgCnBpZD0kJApwYXJhbXZzPSRACnN0cmVhbT0iJHtAOiAtMX0iCnN0cmVhbWlkPSJGRk0kcGlkIgpiaW4xPS92YXIvcGFja2FnZXMvZmZtcGVnL3RhcmdldC9iaW4vZmZtcGVnCmJpbjI9L3Zhci9wYWNrYWdlcy9WaWRlb1N0YXRpb24vdGFyZ2V0L2Jpbi9mZm1wZWcub3JpZwphcmdzPSgpCgp2Y29kZWM9IktPIgoKd2hpbGUgW1sgJCMgLWd0IDAgXV0KZG8KY2FzZSAiJDEiIGluCgktaSkKCQlzaGlmdAoJCW1vdmllPSIkMSIKCQlhcmdzKz0oIi1pIiAiJDEiKQoJOzsKCS1od2FjY2VsKQoJCXNoaWZ0CgkJaHdhY2NlbD0iJDEiCgkJYXJncys9KCItaHdhY2NlbCIgIiQxIikKCTs7Cgktc2NvZGVjKQoJCXNoaWZ0CgkJc2NvZGVjPSIkMSIKCQlhcmdzKz0oIi1zY29kZWMiICIkMSIpCgk7OwoJLWYpCgkJc2hpZnQKCQlmY29kZWM9IiQxIgoJCWFyZ3MrPSgiLWYiICIkMSIpCgk7OwoJLW1hcCkKCQlzaGlmdAoJCWFyZ3MrPSgiLW1hcCIgIiQxIikKCQlpZG1hcD1gZWNobyAkMSB8IGN1dCAtZCA6IC1mIDJgCgkJaWYgWyAiJHZjb2RlYyIgPSAiS08iIF07IHRoZW4KCQkJdmNvZGVjPWAvdmFyL3BhY2thZ2VzL2ZmbXBlZy90YXJnZXQvYmluL2ZmcHJvYmUgLXYgZXJyb3IgLXNlbGVjdF9zdHJlYW1zICRpZG1hcCAtc2hvd19lbnRyaWVzIHN0cmVhbT1jb2RlY19uYW1lIC1vZiBkZWZhdWx0PW5vcHJpbnRfd3JhcHBlcnM9MTpub2tleT0xICIkbW92aWUiIHwgaGVhZCAtbiAxYAoJCQl2Y29kZWNwcm9maWxlPWAvdmFyL3BhY2thZ2VzL2ZmbXBlZy90YXJnZXQvYmluL2ZmcHJvYmUgLXYgZXJyb3IgLXNlbGVjdF9zdHJlYW1zICRpZG1hcCAtc2hvd19lbnRyaWVzIHN0cmVhbT1wcm9maWxlIC1vZiBkZWZhdWx0PW5vcHJpbnRfd3JhcHBlcnM9MTpub2tleT0xICIkbW92aWUiIHwgaGVhZCAtbiAxYAoJCWVsc2UKCQkJYWNvZGVjPWAvdmFyL3BhY2thZ2VzL2ZmbXBlZy90YXJnZXQvYmluL2ZmcHJvYmUgLXYgZXJyb3IgLXNlbGVjdF9zdHJlYW1zICRpZG1hcCAtc2hvd19lbnRyaWVzIHN0cmVhbT1jb2RlY19uYW1lIC1vZiBkZWZhdWx0PW5vcHJpbnRfd3JhcHBlcnM9MTpub2tleT0xICIkbW92aWUiIHwgaGVhZCAtbiAxYAoJCWZpCgk7OwoJKikKCQlhcmdzKz0oIiQxIikKCTs7CmVzYWMKc2hpZnQKZG9uZQoKX2xvZyAiKioqIFBST0NFU1MgU1RBUlQgUkVWICRyZXYgRFMkbmFzICgkYXJjaCkgUElEICRwaWQgKioqIgoKc3RyZWFtZGlyPWBkaXJuYW1lICIkc3RyZWFtImAKZGV2aWNlPWBjYXQgJHtzdHJlYW1kaXJ9L3ZpZGVvX21ldGFkYXRhIHwganEgLXIgJy5kZXZpY2UnYApfbG9nICJERVZJQ0UgICA9ICRkZXZpY2UiCl9sb2cgIk1PVklFICAgID0gJG1vdmllIgoKc2V0IC0tICIke2FyZ3NbQF19IgoKYXJnc25ldz0oKQphcmdzMXN2PSgpCmFyZ3Myc3Y9KCkKYXJnczF2cz0oKQphcmdzMnZzPSgpCgp3aGlsZSBbWyAkIyAtZ3QgMCBdXQpkbwpjYXNlICIkMSIgaW4KCS1zcykKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLXNzIiAiJDEiKQoJCWFyZ3Mxc3YrPSgiLXNzIiAiJDEiKQoJCWFyZ3Mxc3YrPSgiLW5vYWNjdXJhdGVfc2VlayIpCgkJYXJnczF2cys9KCItc3MiICIkMSIpCgkJYXJnczF2cys9KCItbm9hY2N1cmF0ZV9zZWVrIikKCQlhcmdzMnN2Kz0oIi1hbmFseXplZHVyYXRpb24iICIxMDAwMDAwMCIpCgkJYXJnczJ2cys9KCItYW5hbHl6ZWR1cmF0aW9uIiAiMTAwMDAwMDAiKQoJOzsKCS1pKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItaSIgIiQxIikKCQlhcmdzMXN2Kz0oIi1pIiAiJDEiKQoJCWFyZ3Myc3YrPSgiLWkiICJwaXBlOjAiICItbWFwIiAiMCIpCgkJYXJnczF2cys9KCItaSIgIiQxIikKCQlhcmdzMnZzKz0oIi1pIiAicGlwZTowIiAiLW1hcCIgIjAiKQoJOzsKCS12ZikKCQlzaGlmdAoJCWlmIFsgIiRod2FjY2VsIiA9ICJ2YWFwaSIgXSAmJiBbICIkdmNvZGVjcHJvZmlsZSIgPSAiTWFpbiAxMCIgXTsgdGhlbgoJCQlzY2FsZV93PWBlY2hvICIkezF9IiB8IHNlZCAtZSAncy8uKj13PS8vZycgfCBzZWQgLWUgJ3MvOmg9LiovL2cnYAoJCQlzY2FsZV9oPWBlY2hvICIkezF9IiB8IHNlZCAtZSAncy8uKjpoPS8vZydgCgkJCWlmIGxldCAke3NjYWxlX3d9IEFORCBsZXQgJHtzY2FsZV9ofTsgdGhlbgoJCQkJYXJnc25ldys9KCItdmYiICJzY2FsZV92YWFwaT13PSR7c2NhbGVfd306aD0ke3NjYWxlX2h9OmZvcm1hdD1udjEyLGh3dXBsb2FkLHNldHNhcj1zYXI9MSIpCgkJCWVsc2UKCQkJCWFyZ3NuZXcrPSgiLXZmIiAic2NhbGVfdmFhcGk9Zm9ybWF0PW52MTIsaHd1cGxvYWQsc2V0c2FyPXNhcj0xIikKCQkJZmkKCQllbHNlCgkJCWFyZ3NuZXcrPSgiLXZmIiAiJDEiKQoJCWZpCgkJYXJnczJzdis9KCItdmYiICIkMSIpCgkJYXJnczF2cys9KCItdmYiICIkMSIpCgk7OwoJLXZjb2RlYykKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLXZjb2RlYyIgIiQxIikKCQlhcmdzMXN2Kz0oIi12Y29kZWMiICJjb3B5IikKCQlhcmdzMnN2Kz0oIi12Y29kZWMiICIkMSIpCgkJYXJnczF2cys9KCItdmNvZGVjIiAiJDEiKQoJCWFyZ3MydnMrPSgiLXZjb2RlYyIgImNvcHkiKQoJOzsKCS1hY29kZWMpCgkJc2hpZnQKCQlpZiBbICIkMSIgPSAibGliZmFhYyIgXTsgdGhlbgoJCQlhcmdzbmV3Kz0oIi1hY29kZWMiICJhYWMiKQoJCQlhcmdzMXN2Kz0oIi1hY29kZWMiICJhYWMiKQoJCQlhcmdzMnZzKz0oIi1hY29kZWMiICJhYWMiKQoJCWVsc2UKCQkJYXJnc25ldys9KCItYWNvZGVjIiAiJDEiKQoJCQlhcmdzMXN2Kz0oIi1hY29kZWMiICIkMSIpCgkJCWFyZ3MydnMrPSgiLWFjb2RlYyIgIiQxIikKCQlmaQoJCWFyZ3Myc3YrPSgiLWFjb2RlYyIgImNvcHkiKQoJCWFyZ3MxdnMrPSgiLWFjb2RlYyIgImNvcHkiKQoJOzsKCS1hYikKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLWFiIiAiJDEiKQoJCWFyZ3Mxc3YrPSgiLWFiIiAiJDEiKQoJCWFyZ3MydnMrPSgiLWFiIiAiJDEiKQoJOzsKCS1hYykKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLWFjIiAiJDEiKQoJCWFyZ3Mxc3YrPSgiLWFjIiAiJDEiKQoJCWFyZ3MydnMrPSgiLWFjIiAiJDEiKQoJOzsKCS1mKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItZiIgIiQxIikKCQlhcmdzMXN2Kz0oIi1mIiAibXBlZ3RzIikKCQlhcmdzMnN2Kz0oIi1mIiAiJDEiKQoJCWFyZ3MxdnMrPSgiLWYiICJtcGVndHMiKQoJCWFyZ3MydnMrPSgiLWYiICIkMSIpCgk7OwoJLXNlZ21lbnRfZm9ybWF0KQoJCXNoaWZ0CgkJYXJnc25ldys9KCItc2VnbWVudF9mb3JtYXQiICIkMSIpCgkJYXJnczJ2cys9KCItc2VnbWVudF9mb3JtYXQiICIkMSIpCgkJYXJnczJzdis9KCItc2VnbWVudF9mb3JtYXQiICIkMSIpCgk7OwoJLXNlZ21lbnRfbGlzdF90eXBlKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItc2VnbWVudF9saXN0X3R5cGUiICIkMSIpCgkJYXJnczJ2cys9KCItc2VnbWVudF9saXN0X3R5cGUiICIkMSIpCgkJYXJnczJzdis9KCItc2VnbWVudF9saXN0X3R5cGUiICIkMSIpCgk7OwoJLWhsc19zZWVrX3RpbWUpCgkJc2hpZnQKCQlhcmdzbmV3Kz0oIi1obHNfc2Vla190aW1lIiAiJDEiKQoJCWFyZ3MydnMrPSgiLWhsc19zZWVrX3RpbWUiICIkMSIpCgkJYXJnczJzdis9KCItaGxzX3NlZWtfdGltZSIgIiQxIikKCTs7Cgktc2VnbWVudF90aW1lKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItc2VnbWVudF90aW1lIiAiJDEiKQoJCWFyZ3MydnMrPSgiLXNlZ21lbnRfdGltZSIgIiQxIikKCQlhcmdzMnN2Kz0oIi1zZWdtZW50X3RpbWUiICIkMSIpCgk7OwoJLXNlZ21lbnRfdGltZV9kZWx0YSkKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLXNlZ21lbnRfdGltZV9kZWx0YSIgIiQxIikKCQlhcmdzMnZzKz0oIi1zZWdtZW50X3RpbWVfZGVsdGEiICIkMSIpCgkJYXJnczJzdis9KCItc2VnbWVudF90aW1lX2RlbHRhIiAiJDEiKQoJOzsKCS1zZWdtZW50X3N0YXJ0X251bWJlcikKCQlzaGlmdAoJCWFyZ3NuZXcrPSgiLXNlZ21lbnRfc3RhcnRfbnVtYmVyIiAiJDEiKQoJCWFyZ3MydnMrPSgiLXNlZ21lbnRfc3RhcnRfbnVtYmVyIiAiJDEiKQoJCWFyZ3Myc3YrPSgiLXNlZ21lbnRfc3RhcnRfbnVtYmVyIiAiJDEiKQoJOzsKCS1pbmRpdmlkdWFsX2hlYWRlcl90cmFpbGVyKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItaW5kaXZpZHVhbF9oZWFkZXJfdHJhaWxlciIgIiQxIikKCQlhcmdzMnZzKz0oIi1pbmRpdmlkdWFsX2hlYWRlcl90cmFpbGVyIiAiJDEiKQoJCWFyZ3Myc3YrPSgiLWluZGl2aWR1YWxfaGVhZGVyX3RyYWlsZXIiICIkMSIpCgk7OwoJLWF2b2lkX25lZ2F0aXZlX3RzKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItYXZvaWRfbmVnYXRpdmVfdHMiICIkMSIpCgkJYXJnczJ2cys9KCItYXZvaWRfbmVnYXRpdmVfdHMiICIkMSIpCgkJYXJnczJzdis9KCItYXZvaWRfbmVnYXRpdmVfdHMiICIkMSIpCgk7OwoJLWJyZWFrX25vbl9rZXlmcmFtZXMpCgkJc2hpZnQKCQlhcmdzbmV3Kz0oIi1icmVha19ub25fa2V5ZnJhbWVzIiAiJDEiKQoJCWFyZ3MydnMrPSgiLWJyZWFrX25vbl9rZXlmcmFtZXMiICIkMSIpCgkJYXJnczJzdis9KCItYnJlYWtfbm9uX2tleWZyYW1lcyIgIiQxIikKCTs7CgktbWF4X211eGluZ19xdWV1ZV9zaXplKQoJCXNoaWZ0CgkJYXJnczJ2cys9KCItbWF4X211eGluZ19xdWV1ZV9zaXplIiAiJDEiKQoJCWFyZ3Myc3YrPSgiLW1heF9tdXhpbmdfcXVldWVfc2l6ZSIgIiQxIikKCTs7CgktbWFwKQoJCXNoaWZ0CgkJYXJnc25ldys9KCItbWFwIiAiJDEiKQoJCWFyZ3Mxc3YrPSgiLW1hcCIgIiQxIikKCQlhcmdzMXZzKz0oIi1tYXAiICIkMSIpCgk7OwoJKikKCQlhcmdzbmV3Kz0oIiQxIikKCQlpZiBbICIkc3RyZWFtIiA9ICIkMSIgXTsgdGhlbgoJCQlhcmdzMXN2Kz0oIi1idWZzaXplIiAiMTAyNGsiICJwaXBlOjEiKQoJCQlhcmdzMnN2Kz0oIiQxIikKCQkJYXJnczF2cys9KCItYnVmc2l6ZSIgIjEwMjRrIiAicGlwZToxIikKCQkJYXJnczJ2cys9KCIkMSIpCgkJZWxzZQoJCQlhcmdzMnN2Kz0oIiQxIikKCQkJYXJnczF2cys9KCIkMSIpCgkJZmkKCTs7CmVzYWMKc2hpZnQKZG9uZQoKc2VkIC1pIC1lICJzL3tcIlBJRFwiOiR7cGlkfSxcImhhcmR3YXJlX3RyYW5zY29kZVwiOnRydWUsL3tcIlBJRFwiOiR7cGlkfSxcImhhcmR3YXJlX3RyYW5zY29kZVwiOmZhbHNlLC8iIC90bXAvVmlkZW9TdGF0aW9uL2VuYWJsZWQKCnN0YXJ0ZXhlY3RpbWU9YGRhdGUgKyVzYAoKaWYgWyAiJHNjb2RlYyIgPSAic3VicmlwIiBdOyB0aGVuCQoKCV9sb2cgIkZGTVBFRyAgID0gJGJpbjIiCglfbG9nICJDT0RFQyAgICA9ICRzY29kZWMiCglfbG9nICJQQVJBTVZTICA9IgoJX2xvZ19wYXJhICIkcGFyYW12cyIKCQoJJGJpbjIgIiR7YXJnc1tAXX0iICY+IC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciAmCgplbGlmIFsgIiRmY29kZWMiID0gIm1qcGVnIiBdOyB0aGVuCQoKCV9sb2cgIkZGTVBFRyAgID0gJGJpbjIiCglfbG9nICJDT0RFQyAgICA9ICRmY29kZWMiCglfbG9nICJQQVJBTVZTICA9IgoJX2xvZ19wYXJhICIkcGFyYW12cyIKCQoJJGJpbjIgIiR7YXJnc1tAXX0iICY+IC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciAmCgplbHNlCgoJX2xvZyAiVkNPREVDICAgPSAkdmNvZGVjICgkdmNvZGVjcHJvZmlsZSkiCglfbG9nICJBQ09ERUMgICA9ICRhY29kZWMiCglfbG9nICJQQVJBTVZTICA9IgoJX2xvZ19wYXJhICIkcGFyYW12cyIKCV9sb2cgIk1PREUgICAgID0gV1JBUCIKCV9sb2cgIkZGTVBFRyAgID0gJGJpbjEiCglfbG9nICJQQVJBTVdQICA9IgoJcGFyYW0xPSR7YXJnc25ld1tAXX0KCV9sb2dfcGFyYSAiJHBhcmFtMSIKCgkkYmluMSAiJHthcmdzbmV3W0BdfSIgJj4gL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyICYKCmZpCgpjaGlsZHBpZD0kIQpfbG9nICJDSElMRFBJRCA9ICRjaGlsZHBpZCIKd2FpdCAkY2hpbGRwaWQKCmlmIGdyZXAgIkNvbnZlcnNpb24gZmFpbGVkISIgL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyIHx8IGdyZXAgIkVycm9yIG9wZW5pbmcgZmlsdGVycyEiIC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciB8fCBncmVwICJVbnJlY29nbml6ZWQgb3B0aW9uIiAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnIgfHwgZ3JlcCAiSW52YWxpZCBkYXRhIGZvdW5kIHdoZW4gcHJvY2Vzc2luZyBpbnB1dCIgL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyOyB0aGVuCgoJX2xvZyAiKioqIENISUxEIEVORCAqKioiCglzdGFydGV4ZWN0aW1lPWBkYXRlICslc2AKCV9sb2cgIlNURE9VVCAgID0iCglfbG9nX3BhcmEgImB0YWlsIC1uIDE1IC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVycmAiCglfbG9nICJNT0RFICAgICA9IFBJUEUgU1YiCglfbG9nICJGRk1QRUcxICA9ICRiaW4xIgoJX2xvZyAiRkZNUEVHMiAgPSAkYmluMiIKCV9sb2cgIlBBUkFNMSAgID0iCglwYXJhbTE9JHthcmdzMXN2W0BdfQoJX2xvZ19wYXJhICIkcGFyYW0xIgoJX2xvZyAiUEFSQU0yICAgPSIKCXBhcmFtMj0ke2FyZ3Myc3ZbQF19CglfbG9nX3BhcmEgIiRwYXJhbTIiCgoJJGJpbjEgIiR7YXJnczFzdltAXX0iIHwgJGJpbjIgIiR7YXJnczJzdltAXX0iICY+IC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciAmCgoJY2hpbGRwaWQ9JCEKCV9sb2cgIkNISUxEUElEID0gJGNoaWxkcGlkIgoJd2FpdCAkY2hpbGRwaWQKCmZpCgppZiBncmVwICJDb252ZXJzaW9uIGZhaWxlZCEiIC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciB8fCBncmVwICJFcnJvciBvcGVuaW5nIGZpbHRlcnMhIiAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnIgfHwgZ3JlcCAiVW5yZWNvZ25pemVkIG9wdGlvbiIgL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyIHx8IGdyZXAgIkludmFsaWQgZGF0YSBmb3VuZCB3aGVuIHByb2Nlc3NpbmcgaW5wdXQiIC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVycjsgdGhlbgoKCV9sb2cgIioqKiBDSElMRCBFTkQgKioqIgoJc3RhcnRleGVjdGltZT1gZGF0ZSArJXNgCglfbG9nICJTVERPVVQgICA9IgoJX2xvZ19wYXJhICJgdGFpbCAtbiAxNSAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnJgIgoJX2xvZyAiTU9ERSAgICAgPSBQSVBFIFZTIgoJX2xvZyAiRkZNUEVHMSAgPSAkYmluMiIKCV9sb2cgIkZGTVBFRzIgID0gJGJpbjEiCglfbG9nICJQQVJBTTEgICA9IgoJcGFyYW0xPSR7YXJnczF2c1tAXX0KCV9sb2dfcGFyYSAiJHBhcmFtMSIKCV9sb2cgIlBBUkFNMiAgID0iCglwYXJhbTI9JHthcmdzMnZzW0BdfQoJX2xvZ19wYXJhICIkcGFyYW0yIgoKCSRiaW4yICIke2FyZ3MxdnNbQF19IiB8ICRiaW4xICIke2FyZ3MydnNbQF19IiAmPiAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnIgJgoKCWNoaWxkcGlkPSQhCglfbG9nICJDSElMRFBJRCA9ICRjaGlsZHBpZCIKCXdhaXQgJGNoaWxkcGlkCgpmaQoKaWYgZ3JlcCAiQ29udmVyc2lvbiBmYWlsZWQhIiAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnIgfHwgZ3JlcCAiRXJyb3Igb3BlbmluZyBmaWx0ZXJzISIgL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyIHx8IGdyZXAgIlVucmVjb2duaXplZCBvcHRpb24iIC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciB8fCBncmVwICJJbnZhbGlkIGRhdGEgZm91bmQgd2hlbiBwcm9jZXNzaW5nIGlucHV0IiAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnI7IHRoZW4KCglfbG9nICIqKiogQ0hJTEQgRU5EICoqKiIKCXN0YXJ0ZXhlY3RpbWU9YGRhdGUgKyVzYAoJX2xvZyAiU1RET1VUICAgPSIKCV9sb2dfcGFyYSAiYHRhaWwgLW4gMTUgL3RtcC9mZm1wZWctJHtzdHJlYW1pZH0uc3RkZXJyYCIKCV9sb2cgIk1PREUgICAgID0gT1JJRyIKCV9sb2cgIkZGTVBFRyAgID0gJGJpbjIiCgoJJGJpbjIgIiR7YXJnc1tAXX0iICY+IC90bXAvZmZtcGVnLSR7c3RyZWFtaWR9LnN0ZGVyciAmCgoJY2hpbGRwaWQ9JCEKCV9sb2cgIkNISUxEUElEID0gJGNoaWxkcGlkIgoJd2FpdCAkY2hpbGRwaWQKCmZpCgpzdG9wZXhlY3RpbWU9YGRhdGUgKyVzYAppZiB0ZXN0ICQoKHN0b3BleGVjdGltZS1zdGFydGV4ZWN0aW1lKSkgLWx0IDEwOyB0aGVuCglfbG9nICJTVERPVVQgICA9IgoJX2xvZ19wYXJhICJgdGFpbCAtbiAxNSAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnJgIgpmaQoKX2xvZyAiKioqIENISUxEIEVORCAqKioiCl9sb2cgIioqKiBQUk9DRVNTIEVORCAqKioiCgpybSAvdG1wL2ZmbXBlZy0ke3N0cmVhbWlkfS5zdGRlcnI=" | base64 --decode > /var/packages/VideoStation/target/bin/ffmpeg
}

function install() {
    # Save VideoStation's ffmpeg
    mv -n /var/packages/VideoStation/target/bin/ffmpeg /var/packages/VideoStation/target/bin/ffmpeg.orig
    # # Injecting the script (last revision aka 12)
    # wget -O - https://gist.githubusercontent.com/BenjaminPoncet/bbef9edc1d0800528813e75c1669e57e/raw/ffmpeg-wrapper > /var/packages/VideoStation/target/bin/ffmpeg
    generate_ffmpeg_wrapper
    if [ -f "/var/packages/CodecPack/target/bin/ffmpeg33" ]; then
        mv -n /var/packages/CodecPack/target/bin/ffmpeg33 /var/packages/CodecPack/target/bin/ffmpeg33.orig
        cp -n /var/packages/VideoStation/target/bin/ffmpeg /var/packages/CodecPack/target/bin/ffmpeg33
        chmod 755 /var/packages/CodecPack/target/bin/ffmpeg33
    fi
    if [ -f "/var/packages/CodecPack/target/bin/ffmpeg41" ]; then
        mv -n /var/packages/CodecPack/target/bin/ffmpeg41 /var/packages/CodecPack/target/bin/ffmpeg41.orig
        cp -n /var/packages/VideoStation/target/bin/ffmpeg /var/packages/CodecPack/target/bin/ffmpeg41
        chmod 755 /var/packages/CodecPack/target/bin/ffmpeg41
    fi
    # Change ownership and mode of the script
    chown root:VideoStation /var/packages/VideoStation/target/bin/ffmpeg
    chmod 750 /var/packages/VideoStation/target/bin/ffmpeg
    chmod u+s /var/packages/VideoStation/target/bin/ffmpeg
    # Save VideoStation's libsynovte.so
    cp -n /var/packages/VideoStation/target/lib/libsynovte.so /var/packages/VideoStation/target/lib/libsynovte.so.orig
    chown VideoStation:VideoStation /var/packages/VideoStation/target/lib/libsynovte.so.orig
    # Patch libsynovte.so to authorize DTS, EAC3 and TrueHD
    sed -i -e 's/eac3/3cae/' -e 's/dts/std/' -e 's/truehd/dheurt/' /var/packages/VideoStation/target/lib/libsynovte.so
    echo '请重新启动Video Station，并测试ffmpeg是否正常工作'
}

function uninstall() {
    # Restore VideoStation's ffmpeg, libsynovte.so
    mv -f /var/packages/VideoStation/target/bin/ffmpeg.orig /var/packages/VideoStation/target/bin/ffmpeg
    mv -f /var/packages/VideoStation/target/lib/libsynovte.so.orig /var/packages/VideoStation/target/lib/libsynovte.so
    if [ -f "/var/packages/CodecPack/target/bin/ffmpeg33.orig" ]; then
        mv -f /var/packages/CodecPack/target/bin/ffmpeg33.orig /var/packages/CodecPack/target/bin/ffmpeg33
    fi
    if [ -f "/var/packages/CodecPack/target/bin/ffmpeg41.orig" ]; then
        mv -f /var/packages/CodecPack/target/bin/ffmpeg41.orig /var/packages/CodecPack/target/bin/ffmpeg41
    fi
}

if [ "$vAction" == 'install' ]; then
    if [ ! -f "/var/packages/VideoStation/target/bin/ffmpeg.orig" ]; then
        install
        echo '成功安装支持补丁'
    else
        echo '你已经安装过支持补丁'
        echo '=========================================================================='
        exit 1
    fi
elif [ "$vAction" == 'uninstall' ]; then
    if [ ! -f "/var/packages/VideoStation/target/bin/ffmpeg.orig" ]; then
        echo '你还没安装过支持补丁'
        echo '=========================================================================='
        exit 1
    else
        uninstall
        echo '成功卸载支持补丁'
    fi
else
    echo '错误的命令'
    echo '=========================================================================='
    exit 1
fi
