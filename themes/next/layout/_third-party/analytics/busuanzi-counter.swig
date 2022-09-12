{% if theme.busuanzi_count.enable %}
<div class="busuanzi-count">
  <script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>

  {% if theme.busuanzi_count.total_visitors %}
    <span class="site-uv" title="{{ __('footer.total_visitors') }}">
	本站已有
      <span class="busuanzi-value" id="busuanzi_value_site_uv"></span>
	位访客
	<i class="fa fa-{{ theme.busuanzi_count.total_visitors_icon }}"></i>
    </span>
  {% endif %}
<span> | </span>

  {% if theme.busuanzi_count.total_views %}
    <span class="site-pv" title="{{ __('footer.total_views') }}">
	
      <span class="busuanzi-value" id="busuanzi_value_site_pv"></span>
	次阅读
	<i class="fa fa-{{ theme.busuanzi_count.total_views_icon }}"></i>
    </span>
  {% endif %}
</div>
{% endif %}