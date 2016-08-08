module Elasticsearch
  module API
    module Actions
      # Perform search with ability to use Joins
      # See: search documentation for basic search features
      # See: https://github.com/sirensolutions/siren-join for join features

      def coordinate_search(arguments = {})
        method = HTTP_GET

        valid_params = [
          :analyzer,
          :analyze_wildcard,
          :default_operator,
          :df,
          :explain,
          :fielddata_fields,
          :docvalue_fields,
          :stored_fields,
          :fields,
          :from,
          :ignore_indices,
          :ignore_unavailable,
          :allow_no_indices,
          :expand_wildcards,
          :lenient,
          :lowercase_expanded_terms,
          :preference,
          :q,
          :query_cache,
          :request_cache,
          :routing,
          :scroll,
          :search_type,
          :size,
          :sort,
          :source,
          :_source,
          :_source_include,
          :_source_exclude,
          :stats,
          :suggest_field,
          :suggest_mode,
          :suggest_size,
          :suggest_text,
          :terminate_after,
          :timeout,
          :version ]

        path = Utils.__pathify(
          Utils.__listify(arguments[:index]),
          Utils.__listify(arguments[:type]),
          UNDERSCORE_COORDINATE_SEARCH
        )

        params = Utils.__validate_and_extract_params arguments, valid_params

        body = arguments[:body]

        params[:fields] = Utils.__listify(params[:fields], :escape => false) if params[:fields]
        params[:fielddata_fields] = Utils.__listify(params[:fielddata_fields], :escape => false) if params[:fielddata_fields]

        # FIX: Unescape the `filter_path` parameter due to __listify default behavior. Investigate.
        params[:filter_path] =  defined?(EscapeUtils) ? EscapeUtils.unescape_url(params[:filter_path]) : CGI.unescape(params[:filter_path]) if params[:filter_path]

        perform_request(method, path, params, body).body
      end
    end
  end
end