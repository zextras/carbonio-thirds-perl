FROM docker.io/library/ubuntu:noble

ARG TARGETARCH

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates \
 && printf 'deb [arch=%s trusted=yes] https://repo.zextras.tools/repository/ubuntu-devel-jammy jammy main\n' "${TARGETARCH}" \
    > /etc/apt/sources.list.d/zextras.list \
 && apt-get update \
 && todo=carbonio-amavisd && carbonio_pkgs= \
 && while [ -n "${todo}" ]; do \
      set -- ${todo}; pkg=$1; shift; todo="$*"; \
      case " ${carbonio_pkgs} " in *" ${pkg} "*) continue ;; esac; \
      carbonio_pkgs="${carbonio_pkgs} ${pkg}"; \
      todo="${todo} $(apt-cache depends --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances "${pkg}" \
        | awk '/Depends:/ {print $2}' | grep -E '^carbonio-' | grep -v -E '^carbonio-(core|openldap|opendkim)$' | tr '\n' ' ')"; \
    done \
 && system_pkgs=$(apt-cache depends --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances ${carbonio_pkgs} \
      | awk '/Depends:/ {print $2}' | grep -v -E '^(carbonio-|<|service-discover)' | sort -u) \
 && apt-get install -y --no-install-recommends ${system_pkgs} \
 && mkdir -p /tmp/debs && cd /tmp/debs && apt-get download ${carbonio_pkgs} \
 && for deb in /tmp/debs/*.deb; do dpkg -x "$deb" /; done \
 && rm -rf /tmp/debs /var/lib/apt/lists/* /etc/apt/sources.list.d/zextras.list \
 && groupadd -r zextras && useradd -r -g zextras -d /opt/zextras -s /usr/sbin/nologin zextras \
 && mkdir -p /opt/zextras/conf /opt/zextras/data/amavisd/tmp /opt/zextras/data/amavisd/db /opt/zextras/data/amavisd/var \
 && chown -R zextras:zextras /opt/zextras/conf /opt/zextras/data/amavisd

ENV LD_LIBRARY_PATH=/opt/zextras/common/lib
ENV PERL5LIB=/opt/zextras/common/lib/perl5/x86_64-linux-gnu-thread-multi:/opt/zextras/common/lib/perl5/aarch64-linux-gnu-thread-multi:/opt/zextras/common/lib/perl5

COPY docker/amavisd/amavisd.conf.in /opt/zextras/conf/amavisd.conf.in
COPY --chmod=755 docker/amavisd/entrypoint.sh /entrypoint.sh

EXPOSE 10024
USER zextras

ENTRYPOINT ["/entrypoint.sh"]
