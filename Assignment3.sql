CREATE or REPLACE FUNCTION 
	Q11(partial_title text) RETURNS setof text
AS $$
	DECLARE
		_m Movies;
		_partial_title ilike %partial_title%;
	BEGIN
			select 	m.* 
			from 	movies m
					join principals pr on m.id=pr.movie_id
			where 	m.title ilike _partial_title and pr.role not like 'producer'
			group by m.id
			order by m.title ASC
		loop
			return next ''|| _m.title||' has ';-- || ||' cast and crew';
		end loop;
		
		if(not found) then
			return next 'No matching titles';
		end if;

	END;
	
$$ LANGUAGE plpgsql;


select * from Q11('Fight Club');
