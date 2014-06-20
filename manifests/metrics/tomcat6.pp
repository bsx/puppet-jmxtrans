# == Define jmxtrans::metrics::tomcat6
#
# Sets up this Tomcat6 instance to be monitored by a jmxtrans node.
# monitors AJP/HTTP pools and datasources,
# see: https://github.com/jmxtrans/jmxtrans/wiki/MoreExamples
#
# == Parameters
# $jmx            - host:port of JMX to query.  Default: $title
# $jmx_alias      - Server alias name.              Optional.
# $jmx_username   - JMX username (if there is one)  Optional.
# $jmx_password   - JMX password (if there is one)  Optional.
# $ganglia        - $ganglia parameter to pass to jmxtrans::metrics
# $graphite       - $graphite parameter to pass to jmxtrans::metrics
# $outfile        - $outfile parameter to pass to jmxtrans::metrics
# $group_prefix   - Prefix string to prepend to ganglia_group_name and graphite_root_prefix.  Default: ''
#
define jmxtrans::metrics::tomcat6(
    $jmx          = $title,
    $jmx_alias    = undef,
    $jmx_username = undef,
    $jmx_password = undef,
    $ganglia      = undef,
    $graphite     = undef,
    $outfile      = undef,
    $group_prefix = '',
)
{
    jmxtrans::metrics { "${title}-tomcat6-metrics":
        jmx                  => $jmx,
        jmx_alias            => $jmx_alias,
        jmx_username         => $jmx_username,
        jmx_password         => $jmx_password,
        outfile              => $outfile,
        ganglia              => $ganglia,
        ganglia_group_name   => "${group_prefix}tomcat6",
        graphite             => $graphite,
        graphite_root_prefix => "${group_prefix}tomcat6",
        objects              => [
            {
                'name'        => 'Catalina:type=ThreadPool,name=*',
                'resultAlias' => 'connectors',
                'attrs'       => {
                    'currentThreadCount' => {'units' => 'threads', 'slope' => 'both'},
                    'currentThreadsBusy' => {'units' => 'threads', 'slope' => 'both'},
                }
            },
            {
                'name'        => 'Catalina:type=DataSource,class=javax.sql.DataSource,name=*',
                'resultAlias' => 'datasources',
                'attrs'       => {
                  'numActive' => {'units' => 'connections', 'slope' => 'both'},
                  'numIdle'   => {'units' => 'connections', 'slope' => 'both'},
                }
            },
        ]
    }
}
