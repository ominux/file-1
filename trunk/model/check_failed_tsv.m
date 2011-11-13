function y=check_failed_tsv(array,range)
    pattern=array(range(1):range(2));
    y=1;
    if min(pattern) == 0
        y=0;
    end
    