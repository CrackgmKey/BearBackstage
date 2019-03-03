<?php 
return [
        //应用ID,您的APPID。
        'app_id' => "2016082100302320",
        //商户私钥, 请把生成的私钥文件中字符串拷贝在此
        'merchant_private_key' => "MIIEpAIBAAKCAQEAsIM1QBR8NPCLPzEDu+qS5pwGjM6SD55G31pn9F3IUBxNb6mshAz7RmiDxArD53zTKIOzPk/YIb7q3G4eaheNG3+rLW/g29am7ec+/2wk5fVuxbTZe2F1LEoYKbjBo8WyEgvpJDKRx/RZ5TN3tU3m6zYelVdkWUzCPHMMGFRiZaEPApliXHsz3wR4RGrvwDEoq8rPtA0xAnR4+rSTEGjjLP5EIVKnpu0fUUXKyCxKCEZGzIfUDsaE1iNprZeIDnPg2G66iSMTHPl3liM0l7492dM44dXtA9hpPi7LPfNHVGSOZBt9QrOwtrreb32IqSWCM0kiLo7Q3+i9XJCZku/bqQIDAQABAoIBADusX/hF9KfBGpJGc8i3yOoFnYFE5MQ68iLYYYSPoATVTKiPaC9MZDatZr6EFS7RWGG+BH7wZ1UhQi07XTTouV+ujaRSymYH729GWlnnqaHEk6prNYssq3xJoFmaiHxhfY30UOFX50j+JtYBzFqS95pVNYmvfdFizde53UDsZkeM15hu8zhv4dsTpze64td5F7gv+MArZF1T0XOKHDmh0L7Uea/kOKVlLvrVR0v59w/qazLHMoeJDJWGUW2GsJDVnRcSnnLIBYY5SLvn4G+HdgfaMXuzAUNMlaYmOn6Uft9nKJ57AvAyb7PpALfzw2uEWgI2nRQQNOQcV+JV6lr+d/ECgYEA4Vu1vUzxS2FQNUAyXeFlm4R1zQ1S3Dep0Dtea0G+gTNlYirv00Ca6L42xO+ETNQh40Ug7npu3cvvNeiDj1Oz2D8uvnAUmVTL1jgdpTLU3eUfdTyL2AnllXaVbhyXZ7CZ/laozzPXZ1eHUJQclabnz5guK668gTf2SrvduraM+28CgYEAyINFrTO80EjzyN7Co3+KiEk2lpe0mBOsxTmWZp7Cqm/asNQpssfdmf0URF1JWKWW7TKcZt12tZ1riXWVCJZxrBvpK5fxH7lPVcmcCoZrsNhGlSD2XtoVS3O3Ht2diD5GDmSSmZe91I11CZIeN9XUEpIKGgKCqr9dfPMViZQjbmcCgYArOGSFlrEcTOCOJe7C9IyBJAlXtztyArbtucUk+unna40BI8z1Dgnnoztrz6fm+DQ7mzFyq0aCAS+yfhJlNZ9jVNLJMUOyGIIzZnXBDhunJt8+o8sKNvOyE5kbEh6zgzo1fjdH7eBc8HuCJ7XHucfxl3UbaZq7iZkRwjAHNCWbvwKBgQCCBvaxKeLgYt6MPUCVDAlG9ctLftdi4ydfwkdxBrUQF3cGwp7Dy+49hKuW5bPBo6gq624XGrh3b70jp7dcmUrfpD3hwidgPihfZl0lSiQdyzKCVJzPx7aVdlWi023rww5lGP0kUw2L/6uM6E9mP+jFniSk10nq9ivm8i/eRs1vMwKBgQDI9p1myricSLCUxOBi5RojHDayzY20cJuB43O+0sO8VoytAYYxdm26pAkH+NjWkXQ3viQkgh2m0qNqsrhvrvbvwbQ8YuVZlyFf2uArH2RyuPcz6SFq4NvDYdfvLEDWkDrifAOE8Kkz5YEZsJZ/mMgv5tz5qpR/zkmVz4NnzEP4GQ==",
        //异步通知地址
        'notify_url' => "http://demo3.74cms.net/lw/lsnew/index/notifyurl/alipay.html",
        //同步跳转
        'return_url' => "http://demo3.74cms.net/lw/lsnew/index/pay/ali_return_url.html",
        //编码格式
        'charset' => "UTF-8",
        //签名方式
        'sign_type'=>"RSA2",
        //支付宝网关
        'gatewayUrl' => "https://openapi.alipay.com/gateway.do",
        //支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
        'alipay_public_key' => "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2Y9+RZwt4TXHu9g7CtuWl+0EG+2TltuxDto702eUnpY8zlTvHmu/wm46IIHBC0tP+CRqiAbyLrIBH8LUvJlZ018ggfXlsZhlAMYbOA5Y3DLUqfOP+p4Px1shOjiOJg2zWzw9uqJyIjKMX9EWAXH04YMcuP9X/y2p6hQQHm0PARMHYEC183RA8h+Q4kjCH0YFWGi0ylXAdAYmMg/9RATbvIs15MtgdZHe37PWYrlEwM+7cCXD8apKDDFq2QojnVVKneDO9k0w1SCkNbbdoDDK+YuhjBinL/Yku4S648LRttJnkzbrz5UNhudhgiZh8KY8PlTUw7xmxF2JkLCTNiSEaQIDAQAB",
];