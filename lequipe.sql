SELECT video.owner.username, 
video.id, 
video.title, 
COUNT(distinct case when inventory.position = 'preroll' and view.video_started and (inventory.breakid is null or inventory.breakid = 'preroll1') then view.id else null end) as views, 
SAFE_DIVIDE(sum(view.time_watched) , sum(video.duration)) * 100  as VTR ,
EXTRACT (DATE FROM inventory.request_timestamp) AS date,
EXTRACT (HOUR from video.upload_timestamp) as hour,
visitor.device_type
FROM inventory.agnostic_fast`
WHERE partition_name 
BETWEEN '2018-01-01' AND '2018-12-31'
AND (video.owner.parent.id = 36289835
OR video.owner.id = 36289835)
AND (visitor.domain = 'abonnes.lequipe.fr'
or visitor.domain = 'www.lequipe.fr.clonezone.link'
or visitor.domain = 'lebrassarddalex.blogs.lequipemag.fr'
or visitor.domain = 'm.lequipe.fr'
or visitor.domain = 'orig-www.lequipe.fr'
or visitor.domain = 'lequipe.fr'
or visitor.domain = 'prod-m.lequipe.fr'
or visitor.domain = 'webview.lequipe.fr'
or visitor.domain = 'www.lequipe.fr'
or visitor.domain = 'private.lequipe.fr'
or visitor.domain = 'actualites.lequipe.fr'
or visitor.domain = 'qlf-v6.lequipe.fr'
or visitor.domain = 'sportvideo.lequipe.fr'
or visitor.domain = 'video.lequipe.fr'
or visitor.domain = 'free.lequipe.fr'
or visitor.domain = 'lequipe.fr.clonezone.link'
or visitor.domain = 'procycling.lequipe.fr'
or visitor.domain = 'iphdata.lequipe.fr'
or visitor.domain = 'orig-abonnes.lequipe.fr'
or visitor.domain = 'mediaspub.lequipe.fr'
or visitor.domain = 'lequipe21.fr'
or visitor.domain = 'e-adrenaline.fr'
or visitor.domain = 'francefootball.fr'
or visitor.domain = 'www.francefootball.fr'
or visitor.domain = 'webapp.lequipe.fr')
group by 1,2,3,6,7,8
order by Date asc
