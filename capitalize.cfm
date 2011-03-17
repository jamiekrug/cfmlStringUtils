<cfscript>
/*
 * Capitalize a title, intelligently, or just one word.
 *
 * Examples:
 *  capitalize( 'engineering-related fields' )      --> Engineering-Related Fields
 *  capitalize( 'engineering-related fields', ' ' ) --> Engineering-related Fields
 *  capitalize( 'science technologies/technicians' )      --> Science Technologies/Technicians
 *  capitalize( 'science technologies/technicians', ' ' ) --> Science Technologies/technicians
 *  capitalize( source = 'a "quoted" word' )                  --> A "Quoted" Word
 *  capitalize( source = 'a "quoted" word', quoteChars = '' ) --> A "quoted" Word
 *  capitalize( source = 'a title for you' )                   --> A Title for You
 *  capitalize( source = 'a title for you', ignoreWords = '' ) --> A Title For You
 */
	function capitalize(
			required string source,
			string separators = ' -/',
			string ignoreWords = 'a,an,and,as,at,but,by,down,for,from,if,in,into,like,near,nor,of,off,on,onto,or,over,past,so,than,that,the,till,to,upon,when,with,yet',
			string quoteChars = '"'''
			)
	{
		var result = '';
		var separator = left( arguments.separators, 1 );
		var words = listToArray( arguments.source, separator );

		for ( var i = 1; i <= arrayLen( words ); i++ )
		{
			var word = words[ i ];

			// capitalize if not ignored word or first or last word
			if ( i == 1 || i == arrayLen( words ) || !listFindNoCase( arguments.ignoreWords, word ) )
			{
				// capitalize first character, by default
				var charToCap = left( word, 1 );

				// capitalize second character if first character is a quoting character
				if ( len( word ) > 1 && find( charToCap, arguments.quoteChars ) )
					charToCap = mid( word, 2, 1 );

				word = replace( word, charToCap, uCase( charToCap ) );
			}

			if ( len( result ) )
				result &= separator;

			result &= word;
		}

		// recurse, until no more separators
		if ( len( arguments.separators ) > 1 )
			return capitalize( result, right( arguments.separators, len( arguments.separators ) - 1 ), arguments.ignoreWords, arguments.quoteChars );

		return result;
	}
</cfscript>