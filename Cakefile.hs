module Cakefile where

import Development.Cake3
import Development.Cake3.Ext.UrWeb
import Cakefile_P

instance IsString File where fromString = file

project = do

  let pn = "Detach.urp"

  a <- uwapp "-dbms postgres" pn $ do
    debug
    allow mime "text/javascript";
    allow mime "text/css";
    allow mime "image/jpeg";
    allow mime "image/png";
    allow mime "image/gif";
    allow mime "application/octet-stream";
    safeGet "Detach.ur" "C/callback"
    safeGet "Detach.ur" "download"
    database ("dbname="++(takeBaseName pn))
    library' (externalMake "../urweb-callback/lib.urp")
    sql (pn.="sql")
    ur (pair "Detach.ur")

  db <- rule $ do
    let sql = urpSql (toUrp a)
    let dbn = takeBaseName sql
    shell [cmd|dropdb --if-exists $(string dbn)|]
    shell [cmd|createdb $(string dbn)|]
    shell [cmd|psql -f $(sql) $(string dbn)|]
    shell [cmd|touch @(sql.="db")|]

  rule $ do
    phony "all"
    depend db
    depend a

main = do
  writeMake (file "Makefile") (project)
  writeMake (file "Makefile.devel") (selfUpdate >> project)


